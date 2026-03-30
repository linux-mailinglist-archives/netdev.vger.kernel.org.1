Return-Path: <netdev+bounces-273269-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +FesKw+pymmx+gUAu9opvQ
	(envelope-from <netdev+bounces-273269-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 30 Mar 2026 18:47:11 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1682635EFC4
	for <lists+netdev@lfdr.de>; Mon, 30 Mar 2026 18:47:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id F0A423041789
	for <lists+netdev@lfdr.de>; Mon, 30 Mar 2026 16:45:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E32F391846;
	Mon, 30 Mar 2026 16:45:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dama-to.20230601.gappssmtp.com header.i=@dama-to.20230601.gappssmtp.com header.b="LUUIu0Nn"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A099C3A0E97
	for <netdev@vger.kernel.org>; Mon, 30 Mar 2026 16:45:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774889138; cv=none; b=kaWQT4y7lLq6cB7q1w7S8vcb6i0kC2ulULYMjQSjFCQLg9a8SFk9GIoxWuZAZ0CP+vvneAEGFma64LboeuTAr/jDx4Dr/68Mp6p4JDT3dp7yHkJXO+A9xm/nc3Y2u3zBpQjfy0YarMWoyFtFbr8JpbvPHlSg7ijRp0QwIGz2fRM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774889138; c=relaxed/simple;
	bh=IpNnA9s1KINuamNfFsS2gV/eEu/pI6jxdZ/6/nT+doI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C6T8f9rf1LjguauV1QKttRaNVm7saSsmPTNZiHcXyDEVDwNq5v/PWchm+AsMpmvsu5UAfrdWzSzgNrTJw/cmhrekLDszFRVPGwCTz23KNefe0Lyj5nFQOCwfY03ZrG0P5o1pwk4U1js6W5yvGbkO2wguc6ogYJDu5hwyJzP5GKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to; spf=none smtp.mailfrom=dama.to; dkim=pass (2048-bit key) header.d=dama-to.20230601.gappssmtp.com header.i=@dama-to.20230601.gappssmtp.com header.b=LUUIu0Nn; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=dama.to
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2ab232cc803so22339485ad.3
        for <netdev@vger.kernel.org>; Mon, 30 Mar 2026 09:45:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dama-to.20230601.gappssmtp.com; s=20230601; t=1774889136; x=1775493936; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BwE++Vqw+CySglw+oPVi7SkePVFEszmRECwetM66l0k=;
        b=LUUIu0NnPlqE2N6oFk9t68bzUuF/WGQ46GYjp/96iytW8uH1U+ElD8HGdhBpUqHzE0
         SVYLQR3kd1yiH2vS3Jh1taoFYUI+Uv8HJ943nKTDUpfnWmCKW2OiSeibmIV9F8A7KbJB
         omg3/kOpSdBX4WPX/49q+PgCMvt4Est6ljAKXDT9735B6QsOl2LF5CSDYJCbnfejABs9
         ivPeE76fx3mRjix5/8nWUkjxqtDvjskmwxRh/W+TzR36ocXQLn/J+KiuirqFZRbGHJM8
         JqbL638lreTaVI0Tfua4xM+FzSqTJ4DNl742AiWzjqFAMG0J69j22DshZZe7iec8EKeN
         LZJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774889136; x=1775493936;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BwE++Vqw+CySglw+oPVi7SkePVFEszmRECwetM66l0k=;
        b=GCwXvJxZS7G12JynFQjZ7M/IopVvzkOc4MQJVbJnM4/8ToY7JNbHG0LapGViH2FEB/
         RVr+CmlsJpebFNIMsgHdCylCT+23LXszS0NzOjpFiLXyDXd8j7RI0GbfGzYBECoj22IM
         CwmCakSLeHunDdL97R/kJIkUCRkAuEyP/bIrJOko0Ciun/bPT8zR8MjmiatKmIh+M5Dy
         DAVzT3A+1jxeiuGaaDgBPzj6wmLE1ff4DFnEsIgLFmPa+dvbVibEbQ7b0QhRMSK9VTAO
         2tDvWTKKza2Si24CgZ3Tv+TIq7BL7pYDRqyP5u8Q3sk1i3uROWqPD07D4dtV/qyrYxb5
         V/Lg==
X-Gm-Message-State: AOJu0YyUkDK0WfMUqGGg092HBjXvoNbdFLC0W5UuctxVH2EH+b9BWrYS
	ULp8JTBWcwNDS/kFLgqa9Uyl5sme7Xwoszc1g0/kNpam4dXqt/SZYZgpbghmRdg3NWU=
X-Gm-Gg: ATEYQzzH2XmxEFc+hTqXXXeLhCBY+bhmlJ26e4ny3iW1SlvW10khJCAHKFdSwPYrxwN
	kj5dnt31SNnx/1PEHBclgkv2NH6/iTkA2MTyFKL/9tF3vd9JvbCNO5y6MeQywFL2Y1Ja4I7YS1g
	Z5ERFQZpmcLSZib1J9xFFY+ZdYHeSfMFoF7W9trr1j+iLgh352tpAj621OKF9UYWqrbh6lJTNAC
	mtaLuKC2QlwahURigFAiut6sify092YSiCKwbHHfFK+T82b518zlguf5Z6XW96WR9GJwGi5ZFXD
	imZsb7P3We1hQPPLzx8eF5i/yDI1P+pTAHRR3KvzjLybmafRkF7XEY31sJgBqy4KqLKtcXQdHW8
	3523On35fPmq0sOVSkNUP70hmZjT3EbDVagCJMEn17a+ijCeuirKRdWRQEPh6P3AiDXDn0zQ7dc
	qbFcFd+w7L6q0kWI0=
X-Received: by 2002:a17:903:22d2:b0:2b2:58c7:2ce1 with SMTP id d9443c01a7336-2b258c733d1mr25360975ad.36.1774889135767;
        Mon, 30 Mar 2026 09:45:35 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:43::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b242765d3esm109007305ad.47.2026.03.30.09.45.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Mar 2026 09:45:35 -0700 (PDT)
Date: Mon, 30 Mar 2026 09:45:34 -0700
From: Joe Damato <joe@dama.to>
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, Michael Chan <michael.chan@broadcom.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Richard Cochran <richardcochran@gmail.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>, andrew+netdev@lunn.ch,
	horms@kernel.org, pavan.chebbi@broadcom.com,
	linux-kernel@vger.kernel.org, leon@kernel.org, bpf@vger.kernel.org
Subject: Re: [net-next v6 07/12] net: bnxt: Add boilerplate GSO code
Message-ID: <acqorhF1vo1VQjO3@devvm20253.cco0.facebook.com>
Mail-Followup-To: Joe Damato <joe@dama.to>,
	Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org,
	Michael Chan <michael.chan@broadcom.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Richard Cochran <richardcochran@gmail.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>, andrew+netdev@lunn.ch,
	horms@kernel.org, pavan.chebbi@broadcom.com,
	linux-kernel@vger.kernel.org, leon@kernel.org, bpf@vger.kernel.org
References: <20260326235238.2940471-1-joe@dama.to>
 <20260326235238.2940471-8-joe@dama.to>
 <20260329151230.7acacbb9@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260329151230.7acacbb9@kernel.org>
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_ALLOW(-0.20)[dama-to.20230601.gappssmtp.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-273269-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[dama.to];
	FORGED_SENDER_MAILLIST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[vger.kernel.org,broadcom.com,davemloft.net,google.com,redhat.com,gmail.com,kernel.org,iogearbox.net,lunn.ch];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[joe@dama.to,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[dama-to.20230601.gappssmtp.com:+];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,devvm20253.cco0.facebook.com:mid]
X-Rspamd-Queue-Id: 1682635EFC4
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Sun, Mar 29, 2026 at 03:12:30PM -0700, Jakub Kicinski wrote:
> On Thu, 26 Mar 2026 16:52:26 -0700 Joe Damato wrote:
> > @@ -891,6 +891,7 @@ struct bnxt_sw_tx_bd {
> >  	u8			is_ts_pkt;
> >  	u8			is_push;
> >  	u8			action;
> > +	u8			is_sw_gso;
> >  	unsigned short		nr_frags;
> 
> nit: maybe group the is_* together, IOW move new fields before @action?

Sure, will do for the v7. Thanks for the review.

