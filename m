Return-Path: <netdev+bounces-274153-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MFb8BJw/zWkkbAYAu9opvQ
	(envelope-from <netdev+bounces-274153-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 01 Apr 2026 17:54:04 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D86237D83B
	for <lists+netdev@lfdr.de>; Wed, 01 Apr 2026 17:54:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 36B0630CB54F
	for <lists+netdev@lfdr.de>; Wed,  1 Apr 2026 15:28:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FF433914EE;
	Wed,  1 Apr 2026 15:28:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qv/4tX0l"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A0EB223DCE
	for <netdev@vger.kernel.org>; Wed,  1 Apr 2026 15:28:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775057281; cv=pass; b=DSaUUdY/QqbCzNJh652cqF6FIyE4YQZcp9Fx/bpIyS8JrDy6fhXUkOB80WqbrLavRGzcN3ayq+6lkT+a92ObgjWSgWVa4NXmBZYdUVGwoDTiP5qgRLRyzWImH2SFHOYFbaCS2IAHlakSpmIDrLIIE2t1qIvIQEOzB1BuTq0tkzY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775057281; c=relaxed/simple;
	bh=4A/xg9VYn45t8YYunHBNUwIaHOOxM2gP1TF/kZTTzrA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HcMWpOdPSPjioO0xqnrJycYEYJum30uLFK9D1/5A3qR8pjl86UcfZIMYjkmcqNQHyEr0Ve1p5pQb2urQCkEx8cJ9ldnj7wTMTU0DI0l6c2jjRACpHHhpWuRkE2FQok5hHkVfjqZB5tWoIyRwNf9Irc7cUd9hPTzCzSGxY7UrGuk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qv/4tX0l; arc=pass smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-486fb439299so66021855e9.0
        for <netdev@vger.kernel.org>; Wed, 01 Apr 2026 08:27:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775057278; cv=none;
        d=google.com; s=arc-20240605;
        b=NiDHPL8DoujGKFIqZBZWPj0d1pChuJTAGGRNEqbygMNWSeqDx0YCUHZ4Os2e2lj7Uy
         mqMSbNRXXceOIfv5FPCSR32Q36iHqlpIb/br6LsgaujmQBlDLq3VRK287MYAu+loCKLU
         PNxB7HGBghFEU/MpeL6kMwbLGgwxQXhUBOpvzA/7C/RiZJ9gLMkWNXS/1RB2l4HeT0iW
         FGHel+5mvSJTQUoQO0hxsfu+/EDc+fJciAykZ+V8uPtuA9GpEqOiCY0KRPFWI/dZG80R
         AVUxBsUDJN9PeEQlbT9IDXEl/gX3Io34ceAujYvJpvfQSSlWr6pnACWTV2zxSOqEPIwH
         Gc2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=vCOHypGKguo8wBkpBnEw63yLvcdsQkVdKAKwk74anwg=;
        fh=JRWQ63YGL0Lb7gbeeF1NScIx2NJ/nSB4XGjveQQfxH4=;
        b=LvOXVsPt5CCQHTf4U783GQ7VecawQTUqoZesA1ROPxYhWcHSKjFjIWrI+UJJMrISY0
         eaulhKVKqVEV6L6dVW5HgiYJYEmnfvTK+G5qsPamMPsX6qAZPDwSYA6hkxyPV6UQPUND
         WMvy8JhdWNCcpoMdHATGldAZpvAeoV7zeAGjnfC2DRmaPsaVoOjCOnh41zzjI/2t1BPC
         jLA8P1nenJZTaMgK4/iBW8Vcr5X0r9EPrAHLzTegrMI9oTrVZokzaLE0ZHIbU+5yuCww
         09r94SXK5e7MgVLtyAVvKbai8h5Yo3388mT1EB3ITGWMvAo0+ODlmTGLu5FJufKG7oOV
         5vig==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775057278; x=1775662078; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vCOHypGKguo8wBkpBnEw63yLvcdsQkVdKAKwk74anwg=;
        b=qv/4tX0l9OKhkkJH+vDrBljtZYiuCoqt+CNRC1p+kUUZkNUmGpdPGRgxuNhRGrmUWV
         OWawQIcjEVj8SYGrwpmnmzhPeUEAXRAsVuqv4IvFHnwr51jpZ0GLVZmYY5p9pt8VX0qj
         tS2OOjphaT0Cj2NQSYJwIi0eqGqkA9jP9W9KewXaUD8qm6EpUxkUlkC05Z79W2+AbxFY
         igeq6svQN3ddMILocr52O5rr/sf5RWZ+j3bhk2Lar+whTrKsFxmDBEgLH/A/5V0bfSJs
         yoL90cf2n3RqS/Evk48BBfWiLHSdCj3zpsJur787ARAog5z8+OWi2H3UpYgXbWNPNg8l
         NcvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775057278; x=1775662078;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=vCOHypGKguo8wBkpBnEw63yLvcdsQkVdKAKwk74anwg=;
        b=a0qnCsCD00bQiBZLZz/1/NQECEaRsIcsQdwCzERpyXXcRWD94pZGNwOo0Nl8/1gTXU
         IxybMttpd/cw71wXnegj6vLQ2nw4SqV7Fa2BjzDk9q0u6atKsLKinhNY/QhrZcaO7qll
         YIQFbPNxWcS2edHSfbdWqXTUTgE61JFG8TfqQ2rVFjvgwWtvHcArWQcUw8ivc4FOLCO8
         uVX6rmVyy1151AcXnQx6tPDzdHkZwjNwJswlTxkrHJkyAR8Rh0O0MeXzZQlX4YubJbdX
         +ERZDfx0ZqWn4YDX6nd3DOpkFdcuwfIv5GaYD1OD8ii3vPgbpVR/Uizaeh1nExbU/yzH
         Etdw==
X-Forwarded-Encrypted: i=1; AJvYcCWd+v3P6xZjlKsA3cop+KAfcVAyx+WpTo1576XAWJvysczDB+7nftRe4WKM6qfNi8ZI8U8937M=@vger.kernel.org
X-Gm-Message-State: AOJu0YxK7XExk9jf1upyDbLUIOjuH71QXzY85c/p0bgvNaxtWBk6QuIO
	fVZD6i7dQv+c+TFnCZ+hWR197ee9yJDRQeEY0i2BYk5mWYqrtGvnIu7QmI1X0Cc00hQPs/XlMno
	OtOUop97tHuBC5ZucvdxhoBO67ZyAalo=
X-Gm-Gg: ATEYQzxhW62HNoWccyy6rcBOWzOvEZBZIMFPf1qJsxqrSg286Ev8t6HImNrz72MlifE
	BhYBx0FT/PFPodmqBAIFdKTRre4CISL5P83kCO+CiiX9XxeTA23s5UgDNB6Xd+2V4dU9ByPizHk
	GBkih8Hx+AxbTcBxLABULKRLEt66IQw3fjYiZc07CtviT9UU2NBdMtuWLd3Bi+3SXgC3/FV+BiG
	di1VAsVbCVj6FJSUCGV1i7lH8zQUys0gRtIp4MLy/E88rwbpLeVJ21eyAWq9KUg6jPGKGZCM6jv
	HnFibBv1F1WtwNTAXg6+ocrXuCNp5i/kiUodbonqbuPmphfQtYjWjMA7C9z5DaqtTaeSkvtz7d2
	J/WfERoP4fvWNyqAvJcodhTUSKw==
X-Received: by 2002:a05:600c:1f11:b0:486:fd3a:fd22 with SMTP id
 5b1f17b1804b1-48883568b21mr60612905e9.4.1775057278387; Wed, 01 Apr 2026
 08:27:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <ac0Pr9K1Qbn1-Dn9@sirena.org.uk>
In-Reply-To: <ac0Pr9K1Qbn1-Dn9@sirena.org.uk>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Wed, 1 Apr 2026 08:27:46 -0700
X-Gm-Features: AQROBzC7wcHLCyA-6tldZ7Ce9lGnYrr2f0ucx0sfqhOnFZehMHR_aY88d-OhHDw
Message-ID: <CAADnVQJdQRi+763mE8pVoYjgCzhUJNFj5b2YYOrrcLhv9s9-uQ@mail.gmail.com>
Subject: Re: linux-next: manual merge of the bpf-next tree with the bpf tree
To: Mark Brown <broonie@kernel.org>
Cc: Daniel Borkmann <daniel@iogearbox.net>, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>, 
	Networking <netdev@vger.kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, 
	Linux Next Mailing List <linux-next@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-274153-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[iogearbox.net,kernel.org,vger.kernel.org,gmail.com];
	TO_DN_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	MISSING_XM_UA(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[alexeistarovoitov@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Queue-Id: 9D86237D83B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, Apr 1, 2026 at 5:29=E2=80=AFAM Mark Brown <broonie@kernel.org> wrot=
e:
>
> Hi all,
>
> Today's linux-next merge of the bpf-next tree got a conflict in:
>
>   kernel/bpf/verifier.c
>
> between commit:
>
>   a8502a79e832b ("bpf: Fix regsafe() for pointers to packet")
>
> from the bpf tree and commit:
>
>   022ac07508836 ("bpf: use reg->var_off instead of reg->off for pointers"=
)
>
> from the bpf-next tree.
>
> I fixed it up (see below) and can carry the fix as necessary. This
> is now fixed as far as linux-next is concerned, but any non trivial
> conflicts should be mentioned to your upstream maintainer when your tree
> is submitted for merging.  You may also want to consider cooperating
> with the maintainer of the conflicting tree to minimise any particularly
> complex conflicts.

thanks for headsup.
lgtm
we will get it resolved once bpf tree gets pulled.

