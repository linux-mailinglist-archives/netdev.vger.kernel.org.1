Return-Path: <netdev+bounces-253460-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aMIHHq5Yd2lneQEAu9opvQ
	(envelope-from <netdev+bounces-253460-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 26 Jan 2026 13:06:06 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 50C4B87FD2
	for <lists+netdev@lfdr.de>; Mon, 26 Jan 2026 13:06:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3E4ED3002E46
	for <lists+netdev@lfdr.de>; Mon, 26 Jan 2026 12:06:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33F5433064F;
	Mon, 26 Jan 2026 12:06:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="1Zij63wo"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yx1-f54.google.com (mail-yx1-f54.google.com [74.125.224.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FB993346B0
	for <netdev@vger.kernel.org>; Mon, 26 Jan 2026 12:06:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769429163; cv=pass; b=fvf3PkABUfDq+CR9ZaXQQ8C02+vD7xJPnwHrhIKSbvM6dgkeiVREjVWE4+1UGdvSxoEhDe6M9cxlhV5LptpCjNsAz6rzLdSM8m1D/aFgnHHprm7NfzgWotBuFpId94zdEsAQeBK8wDkvKGm1UvJJVk+VbnssJGWcum8IXiu+9W4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769429163; c=relaxed/simple;
	bh=oP1w0AKAafvaItQXb6mntKKiwKfxi+SXpE5jsecUakU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fUj5BtdIZFU3QrkDqGn0YpY60icW1JntWq3xfg3dhc0MxEq38sGZ7Aho/Afs3ypJvSoMDjGqueqNLrpQ5Uwg0rVEcdJRHOLB3dDhnuFMZhkzteOlm5hoae82d1m5KBxyNwvtnpdbFw/j63PumxLCYmeC65e63/MgBH0K473IQlQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b=1Zij63wo; arc=pass smtp.client-ip=74.125.224.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-yx1-f54.google.com with SMTP id 956f58d0204a3-649605d3664so2620304d50.3
        for <netdev@vger.kernel.org>; Mon, 26 Jan 2026 04:06:01 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769429160; cv=none;
        d=google.com; s=arc-20240605;
        b=kcSwVgUNy2BsNypGT/093XpK5Z2793A1ywvACyhfPL64kmTC6zCbZylTgDfsge/3cg
         JesYwhm9YicJywQODIZ+er5LqyBak0Z2dg4kt5WlTPV+yavjfbl+ZZYd8uGQPMFLAaxS
         9dqGmMpuPwHqOlSfWRKLZjy4A2OjyHO6iC6roH/baMr9EnuWCkmT7vn0xyCqW6hG9Okl
         RQZHPOJOfv09lo1hfcH2kXHE2D2o5FyEeJmzxex7xvNCO7GJvdkX21jP3X0II4VTBaek
         mW7UJxq7UXNOgqgf/FoERM0+39CalBlrSRDF7WEBjP/vLUFqtWl1Cik4vUAJRXJUyyaP
         DNOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=oP1w0AKAafvaItQXb6mntKKiwKfxi+SXpE5jsecUakU=;
        fh=NCv5ASnofJ4t0U0jBAj24Y0mSuwq7rQ0dhhDhzgmYnQ=;
        b=JE2su73sV9dbfmVaUV6WLpbqOG8AOM/wmA4B53x8jaEI21WQiyJCOiOXYqqR4D80Wj
         g9Hn2p+Q0ov9vQfV8hXMmRA8p+RlwB6jWAm4joTNqoKyyACpkvDDnriMbzk8T3FQLSAb
         5GHKehQ3pXQhJ8/Brja+V91eq/ZFsw/eC+1UABDXicABd943J+NXSMJ5m8/mtIfKQgih
         gbU3XIH78C0EedcPJAWo0rN6NqSk1hwwT+4k6+Oa39CkpU0GP07ng+DQ+ZR0//JDHpB3
         +cFSSDC9Bvs9bqxVeBPC4IFbe6GYEroCzWqFOdciKU9XEV2kZ55Rjnizf10Cwmt+5U4e
         jvYQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1769429160; x=1770033960; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oP1w0AKAafvaItQXb6mntKKiwKfxi+SXpE5jsecUakU=;
        b=1Zij63woQHziAQzHVfjY0y4htMadKSomdD1Gk1NuT2QFGYHzCpFCItWy+Zts0MuCO1
         BYO4/fqsT6nVR88qnIA8EzaNmSWKsQ4GRa3GG4D5IqO2Ac9RbS3MpIAeY7ADB/MEu0Sf
         zaTI7S+ja2WG81rq+NBhRVDbXB1UnEvLU87RqS4V76kvGI+LglESS4qK0MtLlYeLlkhO
         ope200MpviqKshoz2d9RbsV+GWdTFDvW9vDc2qDsEfjbEfGZWycEuZyXzAfjW0NFCI92
         V6n9j9osKa8lG+ivw4hgEe6WQ+iZzShBCFBRGUMN7ETUZEAWSaBuhIYCrZMiSwZa2iBY
         22SQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769429160; x=1770033960;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=oP1w0AKAafvaItQXb6mntKKiwKfxi+SXpE5jsecUakU=;
        b=RuR2fnUSUjdrad4ouh7R9UqlZayyEn4D9YBOYdEiICiafnvIDnkWk4tw4yEOpsvUQh
         knJXfUj+gFCaJrA27FM/nqRRzhD8JqkY/sw/cLDYGsRaR2SJsTzJb9xiv1AY9iKnRVFC
         JLoWZb2r/qE585ko0ovlBi2s476CCAicppCm+xx1ra7yGrIb1J0P2k1xH3RnHIXrgWEZ
         ZY7NQ8Uuz1xVi/M2dJ9Hzv7WCiHXTmikTB7thIBE6uaBxxKDc3twwo8mxv5Jz9kA94K9
         KslM3lXxCNAvxS3rt1mB/Bml0x/TPOMEY9phre6oMo3EBa9j51QUNdnH3c0VNy5QkiT3
         Lxhg==
X-Gm-Message-State: AOJu0YxWKXdEyLOLYZ+NhIbkrBIpx3GR42oELBxyEGR8M9PWy7cbhxk1
	kR/Is3nMTLTroatmWhblX0NZ/z9KnK/c9NVVlP3FCOe5yN7zb1DHozeHHWlHq+dwizsLPV+x6nE
	1W1HZYb4tPQZPLu4ogcozu2K1EF1j3tOviz6ROran
X-Gm-Gg: AZuq6aLMmv+BmZ9ux2XoGUzAgD2kNw0vaq/1c1HE22cmxx3pdxoKShsZpeOAw+uu/O3
	6Yr73VX8A6VqgRhQX7WSmxFdhNZZqUSjMPND2fj5UtFZzocPS7uKkF1ibCnBH5onTlukDaJMFAl
	ENYKpVbzma+8O6cbnz7qUkaocGlGyJK2dGaOnGxdPyOMDttTAa0leuBpFgeZdQ243NH7oSpHMSo
	chLQsAZZvJX6e10ddcYVn+/PVmi6ZL09IfFdYeSaT6+rKlXkxZz2LAQlEvYnIK75mvx0D/DdTTR
	bdYRG3SbmA==
X-Received: by 2002:a05:690e:bcd:b0:649:44ac:cc01 with SMTP id
 956f58d0204a3-64970ca0981mr2713750d50.55.1769429160609; Mon, 26 Jan 2026
 04:06:00 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260121131954.2710459-1-p@1g4.org> <20260121131954.2710459-7-p@1g4.org>
 <c8a8ae22-c5c4-4112-8084-0faa256a1d84@mojatatu.com> <412136f7-1d46-42ac-96f9-b6cc462204b2@mojatatu.com>
 <77q-JcImMG2fuQxj_GMUtYmaFAIuPrYMasj4I3aqIVID-Op24JIShBIPgt9kozLZgN4HvsGCS8Ez16mKq4Wq9juL1IOKydWUJwMwCYgHRMg=@1g4.org>
In-Reply-To: <77q-JcImMG2fuQxj_GMUtYmaFAIuPrYMasj4I3aqIVID-Op24JIShBIPgt9kozLZgN4HvsGCS8Ez16mKq4Wq9juL1IOKydWUJwMwCYgHRMg=@1g4.org>
From: Victor Nogueira <victor@mojatatu.com>
Date: Mon, 26 Jan 2026 09:05:49 -0300
X-Gm-Features: AZwV_Qg1l52weut7CP9r6jdojpkdt_YToCFRM5o8ot5rEl30mGGPNQW9ipnfrBs
Message-ID: <CA+NMeC-65UfJyq=34_K9tzf9J=-XFPJqDe1BxLNZv0mnjkxZEA@mail.gmail.com>
Subject: Re: [PATCH net v3 6/7] net/sched: act_gate: reject empty schedule list
To: Paul Moses <p@1g4.org>
Cc: netdev@vger.kernel.org, Jamal Hadi Salim <jhs@mojatatu.com>, 
	Cong Wang <xiyou.wangcong@gmail.com>, Jiri Pirko <jiri@resnulli.us>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	R_DKIM_ALLOW(-0.20)[mojatatu-com.20230601.gappssmtp.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[mojatatu.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-253460-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[mojatatu-com.20230601.gappssmtp.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[victor@mojatatu.com,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[vger.kernel.org,mojatatu.com,gmail.com,resnulli.us,davemloft.net,google.com,kernel.org,redhat.com];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,mail.gmail.com:mid,mojatatu-com.20230601.gappssmtp.com:dkim]
X-Rspamd-Queue-Id: 50C4B87FD2
X-Rspamd-Action: no action

On Mon, Jan 26, 2026 at 5:53=E2=80=AFAM Paul Moses <p@1g4.org> wrote:
>
> Should REPLACE with an explicit entry list that yields 0 entries return -=
EINVAL or should it be treated the same as omitting TCA_GATE_ENTRY_LIST and=
 keeping the old schedule?

It should be treated the same as omitting TCA_GATE_ENTRY_LIST and keeping
the old schedule.

cheers,
Victor

