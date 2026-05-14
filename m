Return-Path: <netdev+bounces-287792-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +EYpKU00BWonTQIAu9opvQ
	(envelope-from <netdev+bounces-287792-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 14 May 2026 04:32:45 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2207D53D104
	for <lists+netdev@lfdr.de>; Thu, 14 May 2026 04:32:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1FD673031CDD
	for <lists+netdev@lfdr.de>; Thu, 14 May 2026 02:31:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EAF723ED6A;
	Thu, 14 May 2026 02:31:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E2tS0lWY"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20C8D224AF7
	for <netdev@vger.kernel.org>; Thu, 14 May 2026 02:31:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778725909; cv=pass; b=F6HSdQqLiSKH14v4rOpphuMYqr+IkoT2hTGEDLEHxfJTGdL6BnjzFeeoMGbwvgzZT2dP72PzdqdT9f7KYHBav/yR280TVCVo50wAYbq2ColyjzLUsdnapOAJ3kcBkpeCeRLFpwiZaTUFYHhlnpbsFh2Xxcbs6RI5OoNFp4TTouU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778725909; c=relaxed/simple;
	bh=mW5Bf81e5eqSu3DQckZTqIXYShPDSd/PPa7uyO6CflU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uLF81SGn59VSzuxurk1MCt0jjgKykSWi3G81u5kPAX52dVZ1N+49yDHJMWJrKLOF8wXH9LNH+C6zFkCgvn2C5t6KUrLAztXTqHfulIKPw4CjXfMLvREMZOvIvHLBRNjByX0F5x+j04v8Hx7YP5jLuunbMHmuhVXtS+ZvlIWVMtk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E2tS0lWY; arc=pass smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-b8f97c626aaso401321066b.2
        for <netdev@vger.kernel.org>; Wed, 13 May 2026 19:31:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778725906; cv=none;
        d=google.com; s=arc-20240605;
        b=CCMLy1zR/DjnYK8qvKn+8bRNsuWk//n8SV5DWQ6xb22FSvv4u+5HEOccFEUsY/2Pjo
         1F+eBamhcTAPUCPijoOuP1dzXJT/OtxBGyIlLOXyy/6UewW/3ejL+CWFiJ2x01qbpiUz
         bIBFzXDsIbWaijPVCGgRM2mJZIwA17GHscsqK1KacEdxlaph+Wu0fCu2p244UTMgiOGC
         ema/zU1mrFcog7ZQWzxsI8Bvhke5hOcETZXhWTJLg+zm08Jbs2jBoqkdpz2N3dOdok/7
         dKch8wn+lAe/+SDE7xVs5ETLYX2XS10IqMKkw097zO2LwYgWAqSNjVIVNgwLvD6UFEQg
         RlIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Bt2RW7+FNdxu9onJTUlL3iHw7mRTH/0NpnY2Ilplq90=;
        fh=NoqOuOIoqYudd+mcPi69VOVI3LiJ06PiyEzNUK7iWWE=;
        b=deYKDNI1Bw/Wl3kOKkp5MA40YC/NFsT03IsrtpMJ0di1EaFU4PHbXOs/tWeZ0dHigc
         ATStDW4qbWc/AEz1TUjUh09vC6hAZU6xLZo3KPT3nmhu2iUgzPSt4pVBBTfAK3kG/15c
         ns6uEgrSfnmcD+MJqk+2XOGOB0/pdgFftOhFELCUlKvon0vgtpULKGAVn+YMtOCohjUc
         kLVEGUs1aArWJay/buFQgJ6XZzsUqiFeQrZ3v4P51xVf5o6Mrk9ytqCBR2rNY5VqbI7a
         s4EqgS3tLThVvPlOdvzxbS4ON/1dUbFR4+F30AlaYxYLvtTIR8GJgNz4xHNcpggheq4F
         EIyA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778725906; x=1779330706; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Bt2RW7+FNdxu9onJTUlL3iHw7mRTH/0NpnY2Ilplq90=;
        b=E2tS0lWYNMDeXAkhuWFLCcVzfIOlMt6DRVWC6ffdPv/5N4cO0vZnyuut2Vosu5n9gs
         A48uW8B3kbi+0ofh6oOf9mifJhUwGuezsE1WmkSmaX6z6Di7ON6a91gXhKe1cZJrQaQH
         Bvxlju8mEMkpkvtXDbcrk9BY3Qpi+7N3hBkiREhJ1/A4ke54KtoAlXE3VPC9DOscJwty
         3vlpFMPMNTSBKHs8ORfDsAwSwd6+cQrmW6WC4WTc+QqUg3rvTTyLQrlC/yFyIRCl2LLT
         nF9EQp86B2/mqLY2FRly7QSO1vOemGZJ/2MzsHnvExEatHhDV8NvFh8+3Fkj4EjBkbew
         VzYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778725906; x=1779330706;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Bt2RW7+FNdxu9onJTUlL3iHw7mRTH/0NpnY2Ilplq90=;
        b=b63oCqispxp8nx+92Vx7DvkrAC9m+ZJxOlxvGq2iIsnfebGvcRbVN34b5bS4jbUEWa
         DfCgSh7ZIZQw+P/Mwqe2Oni1a1ScwRuzrV9/n/8hUpprc/0wMkwyGUZKkK8niOK/3m9l
         LxTfsRL0SSZSsYuDTfyJshLldr1/uyMFRLiFPVsHHMEzBTpjrh2hP71OCUSwzgv4DKV4
         i8Bawhj0HYSBtUQN2QKQDcgCXcd3d5lFaVYxtvPNNd2YUu64z1hGq9e7ZXuJKC7oRTxj
         KLDFSE9VrCZGG7iVZ+lwxEnSXmLPAKTzId9JZ16cNAgdgjqM3F5XLZG12XZszT8nkn3o
         Brag==
X-Gm-Message-State: AOJu0Yy1mY2tVw18D24BaNUVPO2WodB48SeBtG8A8MPGAt9O/G/3AwGj
	SLJAVxcHZtusTgf/3pYE1ywXBI934zV8i36V+woCrlI6WUn2T54eLJPiEAVvAsQUR8fxa4xl0nm
	msf9KEx2NE9AZA44JJ07aIXRQ8BlW0ytxDlFk
X-Gm-Gg: Acq92OGVFMW+1XODsoipZbLU/hYU3bLIt7fnnEnmkgZ3Y/4RPvZ7p/H/xxwliziO6Kg
	Ahe6icrRI1yBOJ9CwfuKnhL4Vf0MfeGXi8e0rasyclfpVQMUryxVqGO6HqAc9MGaHEd9Fv7zExF
	k7k/vQ3GC5DB12P9eBuIkdm+OVuLZgIEEhYKHwJYOYAXCMXqPISHxA8i4arKwFnob6XU3TDeS/+
	nv2M0RPRbb+/8SUn1FAskT+K7nr7OC4vAWYfA+bvbi3Zh+qYoXGol1cc0mRevT8s0eG66XCRs8K
	LQUbzZaT0BAgSBcb2UARfod4Br4NCc/Ck5t3tdlAV/VKB2RPolbflxEHAAwRi68=
X-Received: by 2002:a17:906:6a12:b0:bba:5bc9:534a with SMTP id
 a640c23a62f3a-bd3c181d40fmr403418466b.31.1778725906248; Wed, 13 May 2026
 19:31:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260505-seg6-mobile-v2-0-93291b7b0134@gmail.com> <89e9f18f-2fc9-4453-bcdd-96fe31c0a3aa@kernel.org>
In-Reply-To: <89e9f18f-2fc9-4453-bcdd-96fe31c0a3aa@kernel.org>
From: Yuya Kusakabe <yuya.kusakabe@gmail.com>
Date: Thu, 14 May 2026 11:31:34 +0900
X-Gm-Features: AVHnY4JslWirWEjBHsKwtBYW6BSSeaYsySMUB4cXCxuGOGHGnZpdipupVcJ2rBI
Message-ID: <CAGCJULNU9bR4LMQjBMCFERFWkGOz_ZUEJBMHAbFN+2T5kMfFOw@mail.gmail.com>
Subject: Re: [PATCH iproute2-next v2 0/6] seg6: SRv6 Mobile User Plane (RFC 9433)
To: David Ahern <dsahern@kernel.org>
Cc: netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 2207D53D104
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWO(0.00)[2];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-287792-lists,netdev=lfdr.de];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[yuyakusakabe@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	FREEMAIL_FROM(0.00)[gmail.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

On Thu, May 14, 2026 at 10:17=E2=80=AFAM David Ahern <dsahern@kernel.org> w=
rote:
> I am not cc'ed on the netdev patches, so I have no idea the current statu=
s.
>
> Future iproute2 patch sets need to have all uapi changes as a standalone
> patch that I can drop when applying the rest. Headers are synced from
> the kernel.

Hi David,

Thanks for the feedback, and sorry for not cc'ing you on the
kernel-side series.  The matching netdev thread is here:

https://lore.kernel.org/netdev/20260505-seg6-mobile-v2-0-9e8022bdfdb6@gmail=
.com/

Jakub asked me to repost the kernel side as [PATCH RFC net-next]
until review tags accumulate, and Andrea is reviewing both series,
so v3 of this iproute2-next series will follow once that review
lands.

For v3 of this iproute2-next series I will introduce a standalone
leading patch ("uapi: import seg6_local.h SRv6 Mobile attributes
from Linux") for the seg6_local.h sync so you can drop it when
applying the rest, and I will add you to the kernel-side cc from
v3 onwards.

Thanks,
Yuya

