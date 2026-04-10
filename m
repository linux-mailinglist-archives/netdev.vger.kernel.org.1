Return-Path: <netdev+bounces-277365-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QGIsHbbl2GnHjAgAu9opvQ
	(envelope-from <netdev+bounces-277365-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 10 Apr 2026 13:57:42 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C2E973D6752
	for <lists+netdev@lfdr.de>; Fri, 10 Apr 2026 13:57:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4125430AE703
	for <lists+netdev@lfdr.de>; Fri, 10 Apr 2026 11:49:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B3683BE649;
	Fri, 10 Apr 2026 11:49:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20251104.gappssmtp.com header.i=@mojatatu-com.20251104.gappssmtp.com header.b="K74eOzrq"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 409333BFE31
	for <netdev@vger.kernel.org>; Fri, 10 Apr 2026 11:49:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.175
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775821783; cv=pass; b=jO2B9t2dA9fw8r233Eb3PCXwuuUru7Ka6eLYf1R0+bcy5r1TfdUIQvmN7HZhVGGDOjsUdSHGg0aSzLkFa2w3QLOlgzghUEBcljwsUgPhknvk5OpUo3UY0Y7nMMA91HKZrMYXCboccEJLHmUPpEnyM89yTeuzLihPrHhClHMfszc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775821783; c=relaxed/simple;
	bh=uBCwgU/FCqRzbvqSSQDslB759GJm5R3Q2CiFgEn/vEk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=d3sowKwf7DYnjM15zEa0OJZ+pjM0youHjrwBcfa+PCIwqT0CVmMS5YhavQ5/xhMp+gSeRNplyICVSePTn7GODWSDF7QwDlVQHDBNP1TfVs4IXIxrINdcxzX3yoIbrC/9GbBY7RbRe9qnQhHjEWY3J3zWUdMEn2/6zsuBvDhG6QU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (2048-bit key) header.d=mojatatu-com.20251104.gappssmtp.com header.i=@mojatatu-com.20251104.gappssmtp.com header.b=K74eOzrq; arc=pass smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-8296d553142so1142103b3a.3
        for <netdev@vger.kernel.org>; Fri, 10 Apr 2026 04:49:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775821772; cv=none;
        d=google.com; s=arc-20240605;
        b=lXt6LRHE13CK/ah581g+IUbyujDOx9u0I/BnR35JcQ1R9bI+Apvq9w0Pvw+pzAE8pl
         MSnim9QMqG86T+/rStZXUWRnxFv6AZ0vUauV6VjK0JBprhUXlMhvStTmb3GGqDMeCp+k
         k1Ewwj2Dr3DWPeSbbTbjFvnnyUWUrbFMHKLoMMuu0vZbrL3aSl1CrnrvgEc9RMOeqTkm
         m3LB7Al3NIibyETmsyY8f59KXV/3fyYtBO37Y5aA7rRGhgcVpxCZ1kyrNl4DNe8yPFyl
         Oe1MBdXrXXULht5OmwhyXTxxtSR9iX18W5ct7ltVvkpmMDqiOOeTZm2ekUmDCinDKuiE
         mhmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=uBCwgU/FCqRzbvqSSQDslB759GJm5R3Q2CiFgEn/vEk=;
        fh=V5yMvRompT0/NoDZl2VO+R7ZqolHvQUMVf+ADlzfbv4=;
        b=hEzKoTfzyOWqb/Z3f4jTNsE7+TJF42cAxKNYibtNbxy25k/f4KY0g7Q672mclgQzDa
         Wg+y/Vk8E1csHHGUWjb/8Le1AxVLTunrP3YP612bUMq6tqhidcSaOvBdhVzOMaWTmH3E
         uLoeZ1WPgKE/AGjRa56S+x0IF2WLgk1eSdP8b89RRBzw/dhByI/iWyUBuwXCLgmWeoq9
         m1h6WWVsWHu7hJsJE7qd1rt7/jGGsUt9yNmffQAfXBz2rGmkX5oL8uit4knGz0+AG4Tk
         MptM7QxwOTFH/UTfm/IxNgVpYTGxOX3js+MbXA2yOP3Q76du3MZiBxlUWDAhE6z/75xB
         nwWw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20251104.gappssmtp.com; s=20251104; t=1775821772; x=1776426572; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uBCwgU/FCqRzbvqSSQDslB759GJm5R3Q2CiFgEn/vEk=;
        b=K74eOzrqZhybS7hMf/dNrYEqXL0lueeHnvcb2fJhA3uF/FeyZ1fSxD96ml/u5CpfnM
         70dRt/bbfDf7wg0UC1tJBV6OtLcq1BrURqsOUQxmHe6+XMbPH+ElpvLdiuFIR/LUY7w6
         4hB1ap8E0SD+6v/EKGg7xNFHzVlOuSCvIAE2h2YBsESsLwKbAd6GoabIgsSnHek6WFDm
         8yE9uPawYv5lTlfUZ81vWNAz5Pa6S94zluOEs40Anzu7LzoB5VkA9uChb0RStwB3QmYK
         8pVHsAPaXJEv73BJdnDIInSq5R1uvb3RmkqGInBGC93frPY7Dqrs1+mA1A/9GHXb6ZAl
         KaMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775821772; x=1776426572;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=uBCwgU/FCqRzbvqSSQDslB759GJm5R3Q2CiFgEn/vEk=;
        b=VHAcqOISM7iDgWRmrF+xSkT7/89dCzSYBT4jnprvUZtoo+Xm1gk4DV+yGEI0Z/Va+x
         XaQhzJh5f652IJ6cK2IoSo++vyhaGoTnLVFvc3GJq+7Q2HY4zE/dcnLcUpNPjjn6nEhX
         LIn6bwqQ+0GYK+2sG1W0aAH76wSkKWaIVyCZYyb8tCnMA2aGU2HCawVwOMMLwx1Rr7Hu
         N1vKa5o9rTGG7Xe0N64oHd42oMlLYVPD0bNnfy9hkrAeso4rq8Mvak3gZiFizJX+3IF3
         YAgFsABETtM6y6tSha2VNB6zIKUqwrgCdKAi4ZA7JerpM+irZZVZD6mgjRryRCbIVVVV
         OKYQ==
X-Forwarded-Encrypted: i=1; AJvYcCX8Eluzb9XeqJAPunIRbNcIcON9otqKt5w55acRdfPuv3JdCiozHZWVG8N4Inrd4w9oqHYhmMM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxQYKW8s4kgCKsuk5dVuk9ndVTAS1+7N+qWlH81GN4mj8fLjcKb
	cNm8uYRlpAoe10GS5nWpv/O4PIzFxk6IkGuB/HLB4FdiU0fjMJkkSX4EdLoNme1awOKPCcCsWCf
	KWR5nGEVIlH3T0UfitUmiiOzrfsJMfNyuc/TypSz4
X-Gm-Gg: AeBDievqsjRQR5K/S5W3mQWvzxtzlLzGc5nS7n/PPA7HrrDgLYyufb0GttxrnW8tyM5
	TRAxrTSIczQQtJ47V3qn7Nqpf044Vr1QpcnQ7Zw7CWbtdTGB6rtxQRrsZ4crit+Vh1Ettad8vo2
	Ij3mYR4mQQi3TqO/YmkRe32Xv5uONPM1l999dQadT2SMaBZkRLaq+NLyZLVNMZ9C6pzq5586t/k
	UfUgDfW9K6MZhEOodkWTPxsV+iTCjX8ovIQcnn/LODDT8kG+VHrjywn7fkgeXWQDPWpfkPv8kbZ
	nFYXPmc3xIEK2fd4JEw=
X-Received: by 2002:a05:6a00:35ce:b0:781:2291:1045 with SMTP id
 d2e1a72fcca58-82f0c1cf099mr3143895b3a.8.1775821771716; Fri, 10 Apr 2026
 04:49:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260409214914.3072827-1-edumazet@google.com>
In-Reply-To: <20260409214914.3072827-1-edumazet@google.com>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Fri, 10 Apr 2026 07:49:18 -0400
X-Gm-Features: AQROBzBYwjEVmPf7owm_pJCUSTqnbjQh_TegnCF_t4J0y1Iv5G4y2HgxNTBpMP4
Message-ID: <CAM0EoMnPVcdHoy4BNH_sC9H65iu=sHWQcZ25r9_0qcfdjRaTKA@mail.gmail.com>
Subject: Re: [PATCH v2 net-next 00/15] net/sched: prepare RTNL removal from
 qdisc dumps
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Jiri Pirko <jiri@resnulli.us>, 
	Kuniyuki Iwashima <kuniyu@google.com>, netdev@vger.kernel.org, eric.dumazet@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[mojatatu-com.20251104.gappssmtp.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-277365-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[mojatatu.com];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[davemloft.net,kernel.org,redhat.com,resnulli.us,google.com,vger.kernel.org,gmail.com];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jhs@mojatatu.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[mojatatu-com.20251104.gappssmtp.com:+];
	RCPT_COUNT_SEVEN(0.00)[9];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid,mojatatu-com.20251104.gappssmtp.com:dkim]
X-Rspamd-Queue-Id: C2E973D6752
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, Apr 9, 2026 at 5:49=E2=80=AFPM Eric Dumazet <edumazet@google.com> w=
rote:
>
> We add annotations for data-races, so that most dump methods
> can run in parallel with data path.
>
> Then change mq and mqprio to no longer acquire each children
> qdisc spinlock.
>
> Next round of patches will wait for linux-7.2.

Reviewed-by: Jamal Hadi Salim <jhs@mojatatu.com>

with a small caveat: Shouldnt patch #6 onwards go to net?

cheers,
jamal

