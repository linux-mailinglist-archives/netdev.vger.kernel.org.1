Return-Path: <netdev+bounces-266243-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CPerEwlJsGnFhgIAu9opvQ
	(envelope-from <netdev+bounces-266243-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 10 Mar 2026 17:38:33 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E7BBB254F34
	for <lists+netdev@lfdr.de>; Tue, 10 Mar 2026 17:38:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 5C664300AB3D
	for <lists+netdev@lfdr.de>; Tue, 10 Mar 2026 16:38:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC6D23A7580;
	Tue, 10 Mar 2026 16:38:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="COolfrh9"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oa1-f67.google.com (mail-oa1-f67.google.com [209.85.160.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEAFE3C344C
	for <netdev@vger.kernel.org>; Tue, 10 Mar 2026 16:38:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773160709; cv=pass; b=BUm+fvOykEPGWd3MFCO9ii+FD0sjWN59paMgDruNMxeqbC6S3ud+O4rmwnzwq1teoFtytJmQnEe3fQoVLFHdb2sDdZA4squ2AJxtXZR4lt7npScJ2e44AyQctwygt+kVqRQnYluv4FEbXHkUL+JPfrXaqfmoJyvLeLxnkl2wNP8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773160709; c=relaxed/simple;
	bh=aFajtVM6BViJClLSiJy+Dpx1HnVDkA4u8sjvuufy6hI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Cgagewj8kq7bKi/eO/vc1YG0VTfgbsqdo3d6dlEeqnDSZ/ovRLaDonTI/lePsHLaaSWy694yTyeJfvfeYsbIUhEJqH1aK/9fXpMLBUKJl2YJMV6R0/6LirmzgS3lEaKiQ7Z8gZGeBUH4ZnSEQAXvJ1C+8CuBvcwAQSZSLrlCuT4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=COolfrh9; arc=pass smtp.client-ip=209.85.160.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f67.google.com with SMTP id 586e51a60fabf-4170dc73280so314014fac.0
        for <netdev@vger.kernel.org>; Tue, 10 Mar 2026 09:38:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773160707; cv=none;
        d=google.com; s=arc-20240605;
        b=k3qFf5XGjEH3R3SSAX0B/8C5UkcGfgzHkLaRWmttAy9afIKKk2gjthr5MID4RwWRWF
         v8paiHxJxn8sBa0bDfHgI7G/MTx/aXwBsh/eSRA+pQUbVISxF9M8dVT4hGsi45zE4NKo
         KDpQHWTOXROfqPlqtMtc/7uE68P0YOvvuhlDyY1vYg+bUdeuckjNtl9LvNvX4/TZGdYX
         p2IbFk+7hshSfbdf2c9tkT4riyMxeV5fl9ucI4vYhtsrnGgIRr7a7d3160uJM1gVib/k
         EKO9S9KzVRLWCSUURqOrcKyqogpkI5Vry4Blj8vvWIyAokkTwDKx6DG/Oq7aEskSLY7p
         1EEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=uMRnrlTdBO+58lSwC+jvn4I7QDGnU12YOkY7oIpLGI0=;
        fh=GT3PDVFKZm1c/Bywm6sAEjqV3vgBdcYBSgZ/atPN1p0=;
        b=QmJCsJqItWMKcGSar8zGDBDlpWELlF1CVHorWylCb/vcT03flPRXRKvajoKHvtk/Ta
         J0Xy7DA53EPJdV8LL8zb2OuVvn3Ar/ivooeXHr5u67SDG1p+0lbPMyUxqWP2IRNJv1Ta
         FLPaFkcyiR5fGbo5ZmFjle0y7CJRxNgZlC2R0o5cKRnk7+y65PLA+93pet0yNIYzuViM
         9hRUcILtbDGKUosFWdSfw0eJvoQYTJNp6GnZwI5a7KHhkSJJG5JJm+ijj010WKwceToc
         2dkNRz7eU2jNi6cB6ERWralwWk3sOGTeoZCIeLzLHo/dgfs5YMvOsJdIu0YkpFzoIS5K
         L7fg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773160707; x=1773765507; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uMRnrlTdBO+58lSwC+jvn4I7QDGnU12YOkY7oIpLGI0=;
        b=COolfrh9DjGpnd+5k/HO47JWzzFtOPzsXY5sLeHtLzCueEharNhqeKVEMxy9BzerMj
         ubCjSl2NW9fkcDiQeq0TDXSMH0zd42cNlmGlVsLqtI1CPQlAHuy898c4LJ7MImf81lE+
         b8rZinfrKTiVAWGADkUknRwBS0K97jVmfL4yDXp6NxfZs9X/9LX83Fs4O8rBEmu3XFNs
         fs6PX3BXxiLWdhyETynmv12dGYLcr69NuCn/ofVi7I1o6Ascac5K5mbGQr59iDI2/WGU
         lhNqcFoEcPiyVAH7wYvzZcJ87aRJx6i2pnqyx5eW+HTVvCKO8TgOM/OrkU50G36AjwoD
         dXDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773160707; x=1773765507;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=uMRnrlTdBO+58lSwC+jvn4I7QDGnU12YOkY7oIpLGI0=;
        b=FHagn3QzEDoCzP5R+/Sn4G9/Rhjjh0QoXdB3hfpS0baEB3CzhbY1pS2clw14T4nx4j
         ZfUBW++mrhgWZpBw3f7zKmPGL4mdi8goMUvb7gtvEqkeHcLtvqFVf++Wsc8Z33XcMHNb
         T91v8xw257KKg6FXHXZgTnJaZwOI1iEWKGG+FqSzyWAorDvGOs7wV0+YZBFjx1QVQGCH
         OxN1rRubDGoQssbkX9Xiy1lxxFlGLfSm606blP5VS+ekRhnhQbV8B/MT8h452c+LPrY+
         dAeMN+KRqUgUhx1LNhnqKMeS8VTaAtKQekDL+NUdANPadiNeMWr21ksGvFBdG/WUPRsY
         b93Q==
X-Gm-Message-State: AOJu0YwKw5cWraWV7NAP7RJ1/Aqbt2RCtjEbkEgH5l+HidqYsgWotE2t
	xgI+O4WS+jolptH0uYdE1Mj6w63FxUlcVzawIdf/WVXM+E8iZqUrIi331IWrZmRDVxruE7dlJgY
	+FsDFyzuHL9KOhTX+9QU0fOU2YjmIFqs=
X-Gm-Gg: ATEYQzwPf4N/VMWqp3zyj229lNST324N1RPuzaVIeQgERVtjV3cegDwE4RIS+tukO8Q
	c+0uHGmOeX36BNL4cX08u6hrL3MigEpZQVb9euZLef/+8VJXavuoyoWNIejSWR60EpCxV0SYDZr
	Z+LqVlt+bsA/btT9oSi4uZsKKQjbv4UCFgZxa5P+u9ZMfnBjWUpp0Gvp1qXUhSafFw7DGWYCC1k
	Va5MhiyXKsfW0zNg4YoASsLdUqWQ2Ngw/VCjgKE0Zh7qB+LTFVtCV/s0QB3B5KB7DWQHRNyoMLJ
	LVWyANp+1rUzOcUXtIcnfrk=
X-Received: by 2002:a05:6808:1819:b0:467:2609:127d with SMTP id
 5614622812f47-467260980b8mr841958b6e.0.1773160706691; Tue, 10 Mar 2026
 09:38:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260309183454.2872967-1-weibunny.kernel@gmail.com>
 <20260309183454.2872967-3-weibunny.kernel@gmail.com> <aa+BRWjDfSKqcAET@devvm11784.nha0.facebook.com>
In-Reply-To: <aa+BRWjDfSKqcAET@devvm11784.nha0.facebook.com>
From: Wei Wang <weibunny.kernel@gmail.com>
Date: Tue, 10 Mar 2026 09:38:16 -0700
X-Gm-Features: AaiRm53lChjqbfnzX-l0cyD0J1PtoIkRn3k-6hwjoHauG2V5Qa9QjAcqKOfMKe0
Message-ID: <CAGqc4nWWodi3eziemLrFWRkNsuXaZghKWLYjHcddfJhTg6EgWA@mail.gmail.com>
Subject: Re: [PATCH v3 net-next 2/5] psp: add new netlink cmd for dev-assoc
 and dev-disassoc
To: Bobby Eshleman <bobbyeshleman@gmail.com>
Cc: netdev@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>, 
	Daniel Zahka <daniel.zahka@gmail.com>, Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
	David Wei <dw@davidwei.uk>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Wei Wang <weibunny@fb.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: E7BBB254F34
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-266243-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,kernel.org,gmail.com,davidwei.uk,lunn.ch,davemloft.net,google.com,fb.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[weibunnykernel@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,mail.gmail.com:mid,fb.com:email]
X-Rspamd-Action: no action

On Mon, Mar 9, 2026 at 7:26=E2=80=AFPM Bobby Eshleman <bobbyeshleman@gmail.=
com> wrote:
>
> On Mon, Mar 09, 2026 at 11:34:50AM -0700, Wei Wang wrote:
> > From: Wei Wang <weibunny@fb.com>
> >
> > The main purpose of this cmd is to be able to associate a
> > non-psp-capable device (e.g. veth) with a psp device.
> > One use case is if we create a pair of veth/netkit, and assign 1 end
> > inside a netns, while leaving the other end within the default netns,
> > with a real PSP device, e.g. netdevsim or a physical PSP-capable NIC.
> > With this command, we could associate the veth/netkit inside the netns
> > with PSP device, so the virtual device could act as PSP-capable device
> > to initiate PSP connections, and performs PSP encryption/decryption on
> > the real PSP device.
> >
> > Signed-off-by: Wei Wang <weibunny@fb.com>
>
> We'll need to follow in your footsteps for TCP devmem + netkit. I wonder
> if it is possible to decouple this API from PSP?
>
> I have a hack POC that works similarly to the psp associated dev list
> here, but is implicit. It teaches the devmem TX path to allow skbs land
> on netkit_xmit() when that nk has been leased a queue from a device that
> has the support needed (namely, netmem_tx)... but I expect that if there
> is this explicit API, it'll probably be best for devmem to follow suite
> instead of the implicit approach.

Hmm...
The current PSP API looks like this for associating:
./tools/net/ynl/cli.py \
  --spec Documentation/netlink/specs/psp.yaml \
  --do dev-assoc \
  --json '{"id": 1, "assoc-ifindex": 2, "nsid": 0}'
I would guess what could be shared is the last line above where for
PSP, it specifies a PSP dev id, the nk ifindex and nsid.
Maybe the id could be a queue id as well?
But all these are defined in the specific psp.yaml for now. Where do
you envision your devmem API will live?

>
> Best,
> Bobby

