Return-Path: <netdev+bounces-253702-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QOYuGW5BeGlspAEAu9opvQ
	(envelope-from <netdev+bounces-253702-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 27 Jan 2026 05:39:10 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id E9F008FDF1
	for <lists+netdev@lfdr.de>; Tue, 27 Jan 2026 05:39:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 0F030300AB33
	for <lists+netdev@lfdr.de>; Tue, 27 Jan 2026 04:39:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB4872D47E1;
	Tue, 27 Jan 2026 04:39:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j+8j3+MB"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f65.google.com (mail-qv1-f65.google.com [209.85.219.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70A7E245020
	for <netdev@vger.kernel.org>; Tue, 27 Jan 2026 04:39:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.219.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769488747; cv=pass; b=PAsa50Pygqdx5F68QKlQqXiLNicxYSKfS1v5SERndGo1NzCok5zVDY0fDYqpMTrwWvDqw44vlSyEiLbMU6lFna8uZBCiLNWJuIkRt+/D84gMcSPTYqaAfhTI2ONfLot1YyNa9zOoSb/7FS6kHwijMlEIn6sLG7RFIokZyW4mxas=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769488747; c=relaxed/simple;
	bh=n2dNm+rTBUOavMXKUt7vh2BXF/n2U58ixefD3sb72yY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tkgBKoKCPWkDHLb3RJXhRecioEwVyyIjWiiY8IL93d5FwxtODtKwFf9yvdmiXXGxR0iKnIAxvSnRY16ngY4EdXQYfV1lHbbLL9W4U0zENDN4dOm5JkPY4ZPgy8PcYn7wimEcum8uu/A+t/SpmWwcctYgYobDiTYL4jKavE1MZ6E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j+8j3+MB; arc=pass smtp.client-ip=209.85.219.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f65.google.com with SMTP id 6a1803df08f44-8946f12b1cfso64479186d6.0
        for <netdev@vger.kernel.org>; Mon, 26 Jan 2026 20:39:06 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769488745; cv=none;
        d=google.com; s=arc-20240605;
        b=iX0CI+cPq0YsbRKKS50QTGKOZ/nUC23/QeKGJqaDcwItDQWg7QAUwfokuzM4xPaV1v
         IvYPWhO7ztTNxNyaym1TGu7pY4orr6cdGgj3rJVp7OWLdfZobYNB27FgCiCDLzBvqtDW
         HUFXK7oa7OXy2Itq8ERiIf3lxd22ZP9rFC5iBe5M9z0+GdALYguGfiYIBbtkVMJdylrM
         37AYxfrTmyZiMk3DKE6hbJAtRA7oA88FhPTEIaH49evIxpusMpOglDqF1qHmn/V3iRHK
         quI7Ed2GuTxBNXzzz6NXcMUf9Qo/zxCG7RLIA7SkvDSagPSdAp3+VQ2ieB9Pd9rtpJUF
         HnpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ScNgrykGclGtxSSJ1UPVtEbCcvttZim8C+F+P1UH7W0=;
        fh=Ue3s5T3FzWC1gR9h8NJMiJE5Z/QWxbun+Fo1WMA1MXY=;
        b=MxHhgGd7QopPZyuN5xdHuXLJ4jRZHI5OM9g7c8pKM03FjIaCwj9au0wO+aIh4hQNx0
         DU2N5XrNC/PdYznnwAV4NDug75Uva8BgTfe+aIVT81/NSzdkJlIr/CeXUS5JGFIrJq+G
         bj/MfQ2dGAMPIAKanog9RpXbQrkfpC+plrnKXwryBJAPZBJdjDnv27Hf41VvzZ2NeRlr
         BZpKKNk2FF3sK6kk10Xsfw3wEf+6uem32WSxnOLup0Kvbnl+2fTsVEuQYX2PDV7qnbhc
         SdQqr2tSo3eRcj6thyAzfhZQ8HvqURmWIT954JdUPhNIho55DM8VlbaJUuW1RwL79Flz
         zXdw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769488745; x=1770093545; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ScNgrykGclGtxSSJ1UPVtEbCcvttZim8C+F+P1UH7W0=;
        b=j+8j3+MB2iA68HSdBK3bUlfZLjncXscyG/CUwF++4Fq4kT76jCv/tuCCTNb4uE8Er+
         bJ+yCYznS4osF3TUhqAflef/dyzrBr+0hl1xvrHXwLOlbem2dxILqyquGlBQHumxNCGI
         6wtO2WMjLF0QfvPNDLAq+s9YChJ4D0avcm+1+4LnywwehIYSOCjleiNgXSqc6Tlc2yBn
         6K4VVgylxHHXmwC00k9L5wqmvSAsj0LNqCw+fRUhWw3z63xnAwEjZdRRwKHb1nvq8Ow3
         gtiurl2pvc0RN4q/nyx3THMa9hY7QMZ5YosSGhuOu63mL1x1mCRmS0uADysreRwwptml
         PYSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769488745; x=1770093545;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ScNgrykGclGtxSSJ1UPVtEbCcvttZim8C+F+P1UH7W0=;
        b=rwHomhxHOykTZ+wn0N/WF6iv++obid3Pxn8RIGEw/oyAlZtFChmbb/JxFoDasBlPBf
         XGt+1YuZM6UjTKkgGoE9pdxd9mHdty0OhnqhOBtMUWxIfBs7RQZYPzASSlzx//8XMTeL
         iwpL3XZb5n2cpofzegAvJ9lRuSPIcjULOad4rG7jaTnKaMosssYQ1+QN35U0iqkq0tRY
         elEnPIdSFoONYHoloDQ4BWXh69lzlHRNWh79YaKe8yfH6E74NvsNHHyWqgfhCrSc2mLR
         8xmLA0BnU3pSSOx65nF4glB3t60SHWURudYtbAZPalAbHOvl00X2i6kT45vrn8PhU2UY
         Fn2Q==
X-Gm-Message-State: AOJu0Yy7xOuQ8dV7h3cfH7ZLZrwNlfattm4Fxveuap2QPvkdaCScJ47A
	rdcio4jQGnVZD+vdL6Xht9esUMEtlPz9sC2433YAIGT3gc3TRKa0MCNQBdFkra7ptV7QPrDYkSS
	nSMIVkwp/jx876BKuZvjMbFELegeKljw=
X-Gm-Gg: AZuq6aJGMOahSgbIu2rDozCrSUcX/GoXXZ2bGL7Aawopz6DLD7JLAVXYDuX4fZvp/yD
	OMUns1DJ/aSqMIvNB1Th6c6aFM0jQmSj5a5toTXBTe6wKwEtTAbBUT3IaSM9O6A1h0fyx/extrp
	J3rtBlwqR0tnnNEGlcxV02Mn7IcODgL3SVUCqNJbffFup2AUEU1t1w7eDX1x18TE9oBHwebr3Bo
	TxbYg09SZo/RUi8wuvMhDl6VIZ1BtnuwnqeIATczUMPXMu8oEl8Fjme+kHGywAfAIViSOVVR/CW
	iV89jvk1D/A9FgOwsTLvMksA6rsQJnhehy7xNlY+hGxk+mIJG8km+s0T6B5i
X-Received: by 2002:ad4:5d66:0:b0:880:5001:17d1 with SMTP id
 6a1803df08f44-894cc8fd9fbmr6341416d6.37.1769488745351; Mon, 26 Jan 2026
 20:39:05 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260125083501.34513-1-enelsonmoore@gmail.com>
 <20260125083501.34513-4-enelsonmoore@gmail.com> <9239ddef-c197-4fbd-8e88-691766bda3e2@suse.com>
In-Reply-To: <9239ddef-c197-4fbd-8e88-691766bda3e2@suse.com>
From: Ethan Nelson-Moore <enelsonmoore@gmail.com>
Date: Mon, 26 Jan 2026 20:38:54 -0800
X-Gm-Features: AZwV_QiDsJdyHTfe986xy1eQRIgod4TQJMrGFH5ddJp_345K3upd571um_kA9nI
Message-ID: <CADkSEUjgRrC9eAQYOkaErd7wyXKkUs7+dG+Q1jz7VbqF+zxwuw@mail.gmail.com>
Subject: Re: [PATCH net-next 3/3] net: usb: kaweth: remove eth_addr_t typedef
 and bcast_addr definition
To: Oliver Neukum <oneukum@suse.com>
Cc: netdev@vger.kernel.org, linux-usb@vger.kernel.org, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-253702-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	MISSING_XM_UA(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[enelsonmoore@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[8];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,linux-hardware.org:url]
X-Rspamd-Queue-Id: E9F008FDF1
X-Rspamd-Action: no action

On Mon, Jan 26, 2026 at 3:49=E2=80=AFAM Oliver Neukum <oneukum@suse.com> wr=
ote:
>   * Please note: addr must be aligned to u16.
>   */
>
> That requirement is not met. This code will bomb on ARM for example.

Hi, Oliver,

Thanks for noticing this.

It seems like no one is using this driver; there is only one hardware
probe submission on linux-hardware.org containing any device ID
supported by kaweth (of 0557:2002, from Debian 12 on Pentium III
hardware). Therefore, it doesn't make sense to clean it up.

Admittedly, that is only one source, and the number of submissions to
it has dropped recently because it has been having server issues, but
it's still a useful data point.

In comparison, here are the numbers of submissions for a few other devices:
r8152: 0bda:8152 - 1372 (did not check other device IDs)
rtl8150: 0bda:8150 - 18 (did not check other device IDs)
mcs7830: 20 (19 9710:7830, 1 9710:7832)
sr9700: 221 (161 0fe6:9700, 60 0fe6:9702 which I recently added)
sr9800: 0 (I will send a follow-up email regarding next steps to take
regarding this driver)

Hope that helps you get a sense of how much these drivers are being used.

Ethan

