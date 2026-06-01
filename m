Return-Path: <netdev+bounces-293905-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mPalArLuHWotgAkAu9opvQ
	(envelope-from <netdev+bounces-293905-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 01 Jun 2026 22:42:26 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5810262543D
	for <lists+netdev@lfdr.de>; Mon, 01 Jun 2026 22:42:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 33C5B300B130
	for <lists+netdev@lfdr.de>; Mon,  1 Jun 2026 20:42:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBE353BB105;
	Mon,  1 Jun 2026 20:42:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="UkPpt8JA"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FBC938B7B0
	for <netdev@vger.kernel.org>; Mon,  1 Jun 2026 20:42:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780346542; cv=pass; b=pX4BP5DBhv4SoeIPksAJoNxKtvSkJ/0Mgks2iBgmqDlneD4Hdsso6nEKvMXXeOi+AHnJIKrpLSZX0GfCReojPfDPfVrodVxp4kypQtkpr+UrUyoO7umeEhSajjNQaSPNjciBFOf43RgrmCQmgg9a+TQMUWdf/UtzvTjj8YyX2uA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780346542; c=relaxed/simple;
	bh=Gvdi8+4zliRp6O3/y4gLkR/6paVz1EBRxg8RcO1gy8c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cJO8v2eK0v+Afc0aaaNuiX7aDu3uzaCvZIBsuIgz5sTWoQlnGE/shiPYHKU/QqzIplYLvZHwRQcblx1MjM2U1w8FiDWbMQ6+GXYTsZkMoNFHBshtY3rywjx5m6zImmuBWPclijNxZwqtPaVVRfmVKl6bqFZ67N5DuEVks9naHGg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=UkPpt8JA; arc=pass smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-490aaeabdb4so8067675e9.1
        for <netdev@vger.kernel.org>; Mon, 01 Jun 2026 13:42:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780346540; cv=none;
        d=google.com; s=arc-20240605;
        b=Jlokh8iNSQituOlGTS7ssIsIUcBlYFBKNNLxENXpS6Tw4iV8KELVCFo7Qe7sgdkHme
         HiOE57tcqWW4CYsDhPn9/iJ14mBxPjAjQkOmfVHKNCU7/ztdZZLB52lm2nKnRLTmE02H
         LcBO2O9J4I0x0wpWqRDLKrB3Mrg2BUPLpxUCkHQvQFaPyEAOKTb7JC4txufBl2tqEgnn
         M+gb0QdlhETFYsBIF2hu8zdECh4tpDvBY3rSQtPBIO+DlNO+DdAaQkSHqiPkLWPihvI4
         h49vMr3er8QeI5O0EVk29pzNvpzFoqC+hpleziuPvpgQjrjuw22LlEBG89Z7nlP1UlQ4
         vqxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Gvdi8+4zliRp6O3/y4gLkR/6paVz1EBRxg8RcO1gy8c=;
        fh=QRXTu9w39zctloY2KNXjhGamOLCxG/s5uV+JlYp4ZOA=;
        b=dKd9L5tyF0EJ0DuJUMYhJfjeVoXy9bNTpZrf7u2sclNCcF2oNiZ6j2TTDaN3tWtaOL
         f2uTKWf9y4aciNmGkjpUzmfYd3XMZDPdLTxfCQHRoHeWq47VaMF4qoIjp0WTS/aKsSDJ
         EyURA2vO60wWsg86D5ETLTa6PD5B04QvUJfIvE+c4cEBzBEjW5KIYRiBWrM1L8luXYTf
         B5tt5miBx8liJWhCEt07KDGhwjZlujBd29igbkaRlKJCP+wbybWgHeRMticvGkvq+LI4
         dkUbXvU+rwv6kbNLQ6jgdtc8j403wNdKjAn4kjzcerWWbg9eEUMKUB1f9/FON7G+MgiM
         OD7Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780346540; x=1780951340; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Gvdi8+4zliRp6O3/y4gLkR/6paVz1EBRxg8RcO1gy8c=;
        b=UkPpt8JA5DtizVBxcrA/Iqi4obtEUGdhypIM0A29lrUhyDdOq6S4jLE43DWoJuk7k7
         Kps0PJmmxyI43tsUaVB5vbjalam9+Ne7hzB+PzkvLqIVnY/F6gjWx2ShKpx1huuFqN8I
         6DhSu8gTse49l6utq2ZN2gG6t36Kd0ZU0hxIk1ax4Nkz2+nKcIXYbFAPC8jBR8+xCWS7
         O/DrvdPnGPIwQZ2GQZ7Phz8HM51NXNValHIPeNVdmg+dMtUypHiB8l+Xk+EHsaHU8fo7
         zETYTo5u25TnKAw401jlrBir8erQVK2ZFUtc8KLoy7EGoJ1tHsbHQUMjMkn03lP5udZs
         9SnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780346540; x=1780951340;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Gvdi8+4zliRp6O3/y4gLkR/6paVz1EBRxg8RcO1gy8c=;
        b=g2h191LmJ+zESeJLDEnErVvI8NaBgMHA+O70DK+9nJ1eF28zqLIm40zM9gtBODajdt
         NWp+EYj9ToQj2zelyXWaWP0m6u2hr8hZno1DTZeuTI6XVx45z25JnnEYQ1BsRSi35blI
         SoJ/DuU9HnBJ3iC91BCERwQKgCcfTfezR8XY9G5u7CgJXpYfzGi3kox+/X8ZR9n6xx+5
         6tI60KgBbXfWf07VCmReCzrIaIp9mkX/LIEZ/1x4of7xEYMUIlMNYbHGOkXRIHFDbZj3
         lzsKgIDnZEZ0ZcbhOAXUIVV0BynWxGJ6CzW14tZ/6XIN5jgQSatNp2CRgpBAF7ULWQK8
         3GvA==
X-Gm-Message-State: AOJu0YzDyNP7Y1jXXLdsS0+YZOaSmIkwJuowaIxaWeXfHeMZTe2thvyE
	tw0nBJ0ZDVukSlIoBrGxOPFgRwqrMfkkMd3DSjzHkyQwNQff1MHMwEofkn9PKoodcRGhnkXksii
	yRBGT4scdR4PKiRdNyQjCSUUnh3ffzPu2atB694MfSGAZHFFwXcxl6mgo
X-Gm-Gg: Acq92OHB8CZbzbbXzcgui4OA2j1S+1MAIhBs8OttdeU6Caa7AEUUETBWYMGd0h1t/Uf
	zWpZIKZgo8Hzk7CuLjs1i7M4jD7ZRSxB/wyz2vTfzRpog7aNwX4YHSrdyY6iqrXujKFLLPdlh6w
	M1xziIcU3dUGBcPEtEINeEFvJ60hCJ3xOw2uGosEM7yhIUdfjAxyOgBMe6hHcsw7t8iV5etEfKq
	HIpHFQM1CkgtqVRRkR0YQ7XsZds+NLwfMjNqPP2at3rfCOXjY2R8EMNcICpG7bWgNcUqe/knFiX
	COxCDBDjzilxUnN/VHrPBEzkTIL6NQ8ljY5ZXtDacqMiSL1b
X-Received: by 2002:a05:600c:2d4a:b0:490:5057:f602 with SMTP id
 5b1f17b1804b1-490a293dffcmr143077145e9.17.1780346539261; Mon, 01 Jun 2026
 13:42:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CADWJPTsg5G21=hybo81+QHv0+g64d3a+6gGUaJSm1i7EttCUcw@mail.gmail.com>
 <20260529135938.0ba988eb@kernel.org> <20260601080422.0a210edb@kernel.org>
In-Reply-To: <20260601080422.0a210edb@kernel.org>
From: Sheena Mohan <sheenamo@google.com>
Date: Mon, 1 Jun 2026 13:42:07 -0700
X-Gm-Features: AVHnY4LYoLPN_Cc0SxCecX79_v1pq2iyCC2zLSKEVKg7uBDJrIQTHinbfEsYszg
Message-ID: <CADWJPTtr6dEBt8RTGJMBrtQF_hK5dD_QOvjYYE1_tphcnAB05A@mail.gmail.com>
Subject: Re: [ANN] Google's Netdev-CI for IDPF and GVE
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, andrew+netdev@lunn.ch, davem@davemloft.net, 
	Eric Dumazet <edumazet@google.com>, pabeni@redhat.com, horms@kernel.org, 
	Willem de Bruijn <willemb@google.com>, Max Yuan <maxyuan@google.com>, 
	Pin-yen Lin <treapking@google.com>, Harshitha Ramamurthy <hramamurthy@google.com>, 
	Joshua Washington <joshwash@google.com>, Danny Gonzalez <digonzal@google.com>, 
	David Decotigny <decot@google.com>, Brian Vazquez <brianvv@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-293905-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sheenamo@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:url,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,mail.gmail.com:mid,gve-netdev-nipa.static.usercontent.goog:url,idpf-netdev-nipa.static.usercontent.goog:url]
X-Rspamd-Queue-Id: 5810262543D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Thank you Jakub. Our latest results should use the correct branch.

On Mon, Jun 1, 2026 at 8:04=E2=80=AFAM Jakub Kicinski <kuba@kernel.org> wro=
te:
>
> On Fri, 29 May 2026 13:59:38 -0700 Jakub Kicinski wrote:
> > On Fri, 29 May 2026 13:44:48 -0700 Sheena Mohan wrote:
> > > We are happy to share that Netdev-CI testing on both IDPF (running on
> > > Google Bare Metal) and GVE (running on Google Virtual Machines) is no=
w
> > > up and running.
> > > This NIPA integration work enables executing kselftests against the
> > > current proposed net-next kernel branch on real hardware.
> > >
> > > Thanks to Danny, Max, and Pin-yen for their contributions!
> > >
> > > The test results and logs are available in:
> > >
> > > IDPF Results: https://idpf-netdev-nipa.static.usercontent.goog/json/r=
esults.json
> > > GVE Results: https://gve-netdev-nipa.static.usercontent.goog/json/res=
ults.json
> >
> > Awesome stuff! Pulling the results now.
>
> Hi! You seem to be pulling the wrong branch stream. Please switch to:
>
> https://netdev.bots.linux.dev/contest/branches-hw.json

