Return-Path: <netdev+bounces-269635-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sBSeM5xWvGm+xAIAu9opvQ
	(envelope-from <netdev+bounces-269635-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 19 Mar 2026 21:03:40 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 375AC2D1E7E
	for <lists+netdev@lfdr.de>; Thu, 19 Mar 2026 21:03:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E0AD330E6452
	for <lists+netdev@lfdr.de>; Thu, 19 Mar 2026 20:02:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF68C358372;
	Thu, 19 Mar 2026 20:02:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="p+SIy43b"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAAC42E62D1;
	Thu, 19 Mar 2026 20:02:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773950569; cv=none; b=dunN+u0iTRweRPsfRuWvXCVMXmug3g+0Nf6b/28YTrDvaj8Vv9+HBIa7c04SOzP+KFdJ166v1Ud7Ssmu3c1P0jNM9hNrY6UHZV5s7D+b7gigj/sfzT7xLXyEK39nUrAxudAcsVs48PjsTxlazyo3mJaQ6wtSMpXEcD7ttNSFyiE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773950569; c=relaxed/simple;
	bh=w1ldj/8KOcFljXet43ZpLfzZtm1Cmavg2oBXxuBG9/g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ojHVY5dX1onXY7CV+5qgDHEazXxrB8RfSMg2bCbjDFMTMlAS+Zp0fI1aWEVUuOzaFkAP8QOED7pkUTVFFt4EyuxUvB3SgHnDpQVeRv9I871Lc8qpaAL9XeRg2/FTMgcx7nk+oHqb7thvz4Z/SUpYpmqNA56bFtjLC7fPrnsk2cA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=p+SIy43b; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB413C19424;
	Thu, 19 Mar 2026 20:02:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773950569;
	bh=w1ldj/8KOcFljXet43ZpLfzZtm1Cmavg2oBXxuBG9/g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=p+SIy43bYXvanb436yLIo1g/eV+j4uYKwB1M+qhi07KdbtxLGOTtyLd+kQ1IDPXDM
	 1I0YVtMep1cxV+Y2a+r3m66lpeZitFADef6xZPYtuYqrvf/b8zJw49194Yxhuj2e/R
	 hDZVQHyOs20sC9unZhTKSp7VNWIdLDSepAvIY00yuIH/4qYTfxSjHWMfUmh35Gdsg5
	 Civ6+/8oqEhoz+XYnnIobGab/cAzpyB1LIVqzaKI4z0EfzV6oYmg71d2jG+6yFLkah
	 Q31ESYN9z69zhP7k0umgFUhLeqoT0grW3BjRzMl1VoRHs5aFvLEhXO7p32KOBhUba+
	 OZENJo+Nl45cw==
Date: Thu, 19 Mar 2026 20:02:43 +0000
From: Simon Horman <horms@kernel.org>
To: Joshua Washington <joshwash@google.com>
Cc: netdev@vger.kernel.org, Harshitha Ramamurthy <hramamurthy@google.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Willem de Bruijn <willemb@google.com>,
	Praveen Kaligineedi <pkaligineedi@google.com>,
	Tim Hostetler <thostet@google.com>, linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org, Jordan Rhee <jordanrhee@google.com>
Subject: Re: [PATCH net-next] gve: add XDP metadata support for DQ RDA
Message-ID: <20260319200243.GU1753385@horms.kernel.org>
References: <20260316230434.1398828-1-joshwash@google.com>
 <CALuQH+WVSVuan2WRtnugnWo0ZK7dG4Z6BWgHQVULb6m5TZ7vrA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CALuQH+WVSVuan2WRtnugnWo0ZK7dG4Z6BWgHQVULb6m5TZ7vrA@mail.gmail.com>
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-269635-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,google.com,lunn.ch,davemloft.net,kernel.org,redhat.com,iogearbox.net,gmail.com,fomichev.me];
	RCPT_COUNT_TWELVE(0.00)[19];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.959];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[horms@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[horms.kernel.org:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 375AC2D1E7E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, Mar 17, 2026 at 09:03:28AM -0500, Joshua Washington wrote:
> Hello, the commit referenced here should have been
> 1b42e07af1ee ("gve: Add Rx HWTS metadata to AF_XDP ZC mode"). I had
> mistakenly drawn the hash from a different repo. I can respin this
> change once others have reviewed it and left potential feedback.
> 
> 
> On Mon, Mar 16, 2026 at 6:04 PM Joshua Washington <joshwash@google.com> wrote:
> >
> > Commit daa7ff1e1269 ("gve: Add Rx HWTS metadata to AF_XDP ZC mode")
> > exposes support for the XDP RX timestamping metadata operation in the DQ
> > RDA mode. While the operation works on its own, the intent was to enable
> > XDP metadata support for the queue format as a whole along with it.
> > Currently bfp_xdp_adjust_meta fails because meta_valid is set to false.

If you respin, then s/bfp/bpf as suggested by AI generated code review.

> > This change updates xdp_buff preparation to set meta_valid to true, so
> > metadata can be fully used by XDP programs.
> >
> > Reviewed-by: Harshitha Ramamurthy <hramamurthy@google.com>
> > Reviewed-by: Jordan Rhee <jordanrhee@google.com>
> > Signed-off-by: Joshua Washington <joshwash@google.com>

...

