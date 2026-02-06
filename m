Return-Path: <netdev+bounces-257623-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QMFtE14ghmm/JwQAu9opvQ
	(envelope-from <netdev+bounces-257623-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 06 Feb 2026 18:09:50 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A5FA8100C01
	for <lists+netdev@lfdr.de>; Fri, 06 Feb 2026 18:09:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 526B6300EFB9
	for <lists+netdev@lfdr.de>; Fri,  6 Feb 2026 17:09:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E761936F40E;
	Fri,  6 Feb 2026 17:09:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fS0z7GCT"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9910D31076A
	for <netdev@vger.kernel.org>; Fri,  6 Feb 2026 17:09:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.169
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770397786; cv=pass; b=vAqBCkOe/jxwZxCUnbNe7Q5Hh2eOC3Bb611kVhUgUI6XSXxqedYgYGz/qmiOjW7qH/fauSsP96ThAtWkt9B9X+m0uWCqOnT1V/Cz/53vnTvBAswwucdfO0w/zVoeOfnq/swR4LDCMWzVtMURNmUoiAlc2g4AMLSDIKBFN18HUGU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770397786; c=relaxed/simple;
	bh=2D3+3zXtP4JhUK7/PLg4nJFv+DRLaz8NltH9x+kquWQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PA7nYQIMZUH+9s7wZoJQ+A68AoUKhbFA5eeNr5KcjrhaovnPakgFdqXsDpN2UAuBCloAH60lmNQxsOfdIvW7zs1Lb99s6xd3buzhQMc3IaHGscoOsch2t3ijTG7hLRSWiFq4K4lJwXeKQqdkLVWSwcHEBxVTgZJbYNEI/Kunl6I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=fS0z7GCT; arc=pass smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-5032e951106so20703671cf.0
        for <netdev@vger.kernel.org>; Fri, 06 Feb 2026 09:09:46 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770397785; cv=none;
        d=google.com; s=arc-20240605;
        b=Xt6QnFYplII2GudI3Kdah0PV9962xFNvHqw1TUWuGDnsEVcBeH6MdeavXLVcaKXPeT
         R06FMAKlLvyN+3SuuaEK8lJRLp6FY9NhfgMCCZEGDSk/daOkGujrbKIKsOGjptKBni9u
         w8MH64z0pAzRhXj3PvdAqA2YRRilok3y2xd8qz57vr1mCH21aUNIGIY3iXymZKYqxv+R
         npbYGbb6akm3EBD2b9FvStlf1mefSDFHwr620lcnJ+aGAAoJZTTgsuc6nlQy3Vsei+dh
         vYyrOCBxpdpTpZlKG2TT/6niqeCZr66Q9RRrKZERTqCxBWSoLwTrW4CU44+7B1gHK6RA
         0Ivw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=2D3+3zXtP4JhUK7/PLg4nJFv+DRLaz8NltH9x+kquWQ=;
        fh=w1m+jv64GJ3CE5zjizhh9RIjBpVp/wflsDWguyBPUuM=;
        b=HOfjDbcbdDVcip6YJYDPvnWo7I4dFTumu39GK1+pMtyN2ldkg/9rXp2+BiwWxRtcvx
         jm/tKxikN17gMgUPN+gRW6FuJDq9Ah/Cw7Nnrvi/yQY4DQPlB0x513FRFAk2WeX/+zjI
         yccCw7lTxamudJyRU9ZEHKtPef5dBcmvhu0GhY6tvoqLlAiwtwgERs0t7YNiHJzz/FT3
         QVBmf8MC/vXShqEsEHXK1RRyQSjMIoBIISQh/Bg57Ab++ogttpOC6ApRchdzvpB8Hz/4
         rpu6GQllvTNYTlRmiza4ZyuVlQIAPSqjMy1bfbTSvGAtFKCAJIJQdv0mkdHM9S9eNONE
         7AoQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1770397785; x=1771002585; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2D3+3zXtP4JhUK7/PLg4nJFv+DRLaz8NltH9x+kquWQ=;
        b=fS0z7GCTc6IbYxJbbtmxP1sW7GNzMyPHokXsdBggcMMvZwxD8wcnyVqn58ub5RkARI
         N29oWTcB97VObPMPz5nSdybnHVRrubxuDLJ4Y9FyEvRsBmPbeQZPpDRATerOu7d1agp+
         PP+L/WQ1IVILvORZGnV6wje4Zg9toBa3shFmntM3hex8oLQOjj1LoRiThBCX9viYfW98
         uamfynpWUp/mtfXsFOiMNsV6ARb+GCrBMU98oCaJU8+ZXjwUa7LnJyMKYT0QBWNtckhV
         qyObzNR+3gLfPFwc5TJ+s6YQOJOgItgxiC/S5cdFrmS+L+22DjPt6hW8p4pjMXAMOF2c
         Bj2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770397785; x=1771002585;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=2D3+3zXtP4JhUK7/PLg4nJFv+DRLaz8NltH9x+kquWQ=;
        b=mvyxTnyGE56zkf+lToG+gMSFndw6mfNPJqGeJOeH+RTQd1ANeZDVMUGz0RXKwr6oD+
         obH1r0lEuIXCeqpT1r646w6Hd3X5j2DhVFaQ+BXvOIYcL1HYscorq/OuDNgAT4k850hb
         jCEEwhxln0qemfLWwR7BcuKb/hKRYULqTvrX86B9cu3ojoeFXtOWGMbekGw5nOWo5CB7
         5Uzc5D35oFyX+kPA3lLOLzbMgpwJF7MTHQeGRppRaDNno5N9FFbFL5M91Xomas5jPr98
         fRHNEcM2iV/8Ltd1nkeA4canpeh9D++n4C7KLH4alcy3O3KWaiDDEgBwA9+MYztIw3G3
         fN9Q==
X-Gm-Message-State: AOJu0YyUFNVgvFIVRQtXFBPJXlUjVUIFqsSm07T8An2uRirGYuIJl3xA
	2C2SmNGujn8YjyuzsoDYlr3u5YaKP9mFMmeuYKKmHtgRCm7bFv/BQqNULS4/o5emLj6vJISVTIW
	Fp7hzWKVsd5Ic/fozRDXo4q/dqWeRiIVC8vruZW65ZnQR63F+lfd2pVEo
X-Gm-Gg: AZuq6aJNsLEJD1v1uDjjBu9n6Lwn41lWrjmLchl6PpBS1v7goaVBRzsDOQxJ1T/YKZb
	bVUBZUQvAfOM1t118OtwxmaMStiUIV231X33BmwtB/Qw4J1yGZKSRdxHXPryXaaBoZJuTtnMPiu
	y8Wc0ZGzDXW+XTkMictn6TcvKjO0OJJDJr3R1B9xXkDVmac4kk/isSNK9IwPg6ys3ehcVxOXYNw
	+RlZm/UusfLmOWRcBV58oNUXXwWuZSgLf6HU4E6bcp1WoUkfKO+zjg0/RFLzFJu5p/aTQ==
X-Received: by 2002:a05:622a:130f:b0:502:e3c8:2e25 with SMTP id
 d75a77b69052e-506399c903emr47797061cf.76.1770397785036; Fri, 06 Feb 2026
 09:09:45 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260203175422.4620-1-fmancera@suse.de> <CANn89i+UUWx5OhPnJnDhiCfr53BPTAGedBucgqYwyfqkidf_Cg@mail.gmail.com>
 <8d94faf9-2fb6-483d-9767-bd665c4a4b9a@suse.de> <1649583d-71c2-425e-a2df-685d5f6dc67d@suse.de>
In-Reply-To: <1649583d-71c2-425e-a2df-685d5f6dc67d@suse.de>
From: Eric Dumazet <edumazet@google.com>
Date: Fri, 6 Feb 2026 18:09:32 +0100
X-Gm-Features: AZwV_Qidxz5uIrMnB8dhKLOScV5vhsNf8LrEzY_iHNMnqdoi8vLbqK75xYPLiXo
Message-ID: <CANn89iK3Pu2NXxejTSLF-7MhBc03_ZJUjOtZcTC4nMsbsDpbSw@mail.gmail.com>
Subject: Re: [PATCH RFC net-next] inet: add ip_retry_random_port sysctl to
 reduce sequential port retries
To: Fernando Fernandez Mancera <fmancera@suse.de>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org, 
	pabeni@redhat.com, horms@kernel.org, corbet@lwn.net, ncardwell@google.com, 
	kuniyu@google.com, dsahern@kernel.org, idosch@nvidia.com, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Thorsten Toepper <thorsten.toepper@sap.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-257623-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	NEURAL_HAM(-0.00)[-0.998];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[0xffsoftware.com:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Queue-Id: A5FA8100C01
X-Rspamd-Action: no action

On Fri, Feb 6, 2026 at 5:28=E2=80=AFPM Fernando Fernandez Mancera
<fmancera@suse.de> wrote:
>
>
>
> It makes sense. I have tested this approach and we got a more even
> distribution of source ports when having thousands of reserved ports. No
> difference at all when not using reserved ports.
>
> Please, you can find the distribution graph with the current algorithm
> [1] and with the random step algorithm [2].
>
> While I understand that this approach is introducing a call to
> get_random_u32_below() on every connect, I am wondering if it makes
> sense to replace the existing algorithm with this variant. What do you
> think?

I would ask RFC 6056 experts like Fernando Gont what they think.

Note that if we use random at each connect(), we defeat one of the principl=
es
of ephemeral port selection : try very hard to avoid 4-tuple collision.

>
> Please, notice the implementation below. I plan to send an official v1
> once net-next is open. In addition, I am rewriting the commit message as
> I find the current one confusing.
>
> [1] https://0xffsoftware.com/port_graph_current_alg.html
>
> [2] https://0xffsoftware.com/port_graph_random_step_alg.html

