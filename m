Return-Path: <netdev+bounces-286683-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YHRbAkbmAWqemAEAu9opvQ
	(envelope-from <netdev+bounces-286683-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 11 May 2026 16:23:02 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id BF7EE51009A
	for <lists+netdev@lfdr.de>; Mon, 11 May 2026 16:23:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 631BF3022B7C
	for <lists+netdev@lfdr.de>; Mon, 11 May 2026 14:16:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40EA93FE371;
	Mon, 11 May 2026 14:16:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C5H9Jvs9"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE4DE3FE34D;
	Mon, 11 May 2026 14:16:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778508996; cv=none; b=iPvHtNyNKTJbPvW4a3eT796xILG6YaY/qfcGH0Xfw68E4DVpLPOp3l8uVbalAaVrOm1I+OemzzO41p4419J0DHePE0G/5ctQPKISj8QK/2bwfJxzoFbO83f1SK7sHq+YHgKLy5CRGscmJx/87u+FLHDO3AioF/EItx7Qm1e1EtU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778508996; c=relaxed/simple;
	bh=l9s76vlJeUgRWNHh/t01VYmRzuAMECx8ccD1yIQ7gaU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aW5txlyz4OzWNgT+nenEnUzbxNBoe7tJczpJpADZSl5NvNd9ucrFG1KWGLPYDsLsnK9vYenTCUIX0pylPKEOk+mlZqPKk9+R/l0PBHosqXFgETOX7LYZjEXcYgxmCHPDM+BA39qwLl5wFm7zrkOaRQtZfsoU0ow7Qdf3e0IPiJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C5H9Jvs9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB9ECC2BCB0;
	Mon, 11 May 2026 14:16:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778508996;
	bh=l9s76vlJeUgRWNHh/t01VYmRzuAMECx8ccD1yIQ7gaU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=C5H9Jvs93HF+O4qvnWcmA1g+XB01ivlwYAHVrb85MQLqRuQpwmAJGXaTF2EwB7Ljg
	 MNPKHsxrhByfdlU8xa/tNF0C32J2/1PywMEaO/OOgsQYtn1TBFmDt6hgkYHCwYmQvq
	 axnvoOAgHGVO9Uj448mr4tgg++SX/8XsbJPOz3q9eGJqB39XUT/8FlIc2NWYISnLZY
	 ZUqU+XrbIqAgwWtePfl4OA92evxrtCSYheV1JXzH1eJ8bPsTEif6pHsvjkMitNpIhe
	 4Odc0kdvHgEvPQufjW46xeYZUn6pYzbAAi4Ta7bHJ11MuXcsLLmHlC0H3IxQ4n5ikR
	 6cCZqIN36v/UA==
Date: Mon, 11 May 2026 07:16:34 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Jason Xing <kerneljasonxing@gmail.com>
Cc: davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 bjorn@kernel.org, magnus.karlsson@intel.com, maciej.fijalkowski@intel.com,
 jonathan.lemon@gmail.com, sdf@fomichev.me, ast@kernel.org,
 daniel@iogearbox.net, hawk@kernel.org, john.fastabend@gmail.com,
 horms@kernel.org, andrew+netdev@lunn.ch, bpf@vger.kernel.org,
 netdev@vger.kernel.org, Jason Xing <kernelxing@tencent.com>
Subject: Re: [PATCH net 0/4] xsk: fix meta and publish of cq issues
Message-ID: <20260511071634.463aea60@kernel.org>
In-Reply-To: <20260510012310.88570-1-kerneljasonxing@gmail.com>
References: <20260510012310.88570-1-kerneljasonxing@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: BF7EE51009A
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-286683-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[18];
	FREEMAIL_CC(0.00)[davemloft.net,google.com,redhat.com,kernel.org,intel.com,gmail.com,fomichev.me,iogearbox.net,lunn.ch,vger.kernel.org,tencent.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Action: no action

On Sun, 10 May 2026 09:23:06 +0800 Jason Xing wrote:
> The series is the product of previous review from sashiko[1].

This series breaks the BPF selftests, it seems:

Error: #277 ns_xsk_drv
Error: #277/21 ns_xsk_drv/ALIGNED_INV_DESC_MULTI_BUFF
Error: #277/22 ns_xsk_drv/TOO_MANY_FRAGS
Error: #278 ns_xsk_skb
Error: #278/21 ns_xsk_skb/ALIGNED_INV_DESC_MULTI_BUFF
Error: #278/22 ns_xsk_skb/TOO_MANY_FRAGS

