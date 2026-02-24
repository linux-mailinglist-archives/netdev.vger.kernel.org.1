Return-Path: <netdev+bounces-260491-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MMXTJ+mQnWlKQgQAu9opvQ
	(envelope-from <netdev+bounces-260491-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 24 Feb 2026 12:52:09 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id CA4AF1869D1
	for <lists+netdev@lfdr.de>; Tue, 24 Feb 2026 12:52:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id CF5B3300B503
	for <lists+netdev@lfdr.de>; Tue, 24 Feb 2026 11:48:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E62037F759;
	Tue, 24 Feb 2026 11:48:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="T7+m6hgV";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ggbLvw7G"
X-Original-To: netdev@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7351C2D6E6F
	for <netdev@vger.kernel.org>; Tue, 24 Feb 2026 11:48:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771933708; cv=none; b=jaQHQKCntYzo8BtJCbP9nnpaTKG+deB8Tt99VaNlEibhuUwUruTjNEdVDCDIHc//nufQt//7VdsFdw2CyFxBKjsonkkkSO3aLZDsffFMpZvAkF4a6lQTgvbbl4xsXIJgUs4IRsWc4l6dc6L8dnUoG/T+FU0HCKSa4IcfVcqelWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771933708; c=relaxed/simple;
	bh=ZNXwg8QYndxIfx8MnaP4oxEcPC1FDybZnk3gke92xDw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZuZGIaD3u1sH92jAzERwme/DXU4tK+eU9t/M8RXTWGeIqx9XHXwg+Vnt89+a+2o5JdXadUKSLHLTJ+6nUdVzf78Rk5arKaFXTULkHSyp6zMDE4vj/Cb4SRQVRmC5SasBmsqoU5TbbN7Niq/GyCHAyfnS5IomhxhdYo4WU9zjAQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=T7+m6hgV; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ggbLvw7G; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 24 Feb 2026 12:48:23 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1771933705;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=zAwsw+54U1JkBpviU3oyDxnbrMl/pdFkaDxG0Nxfr+M=;
	b=T7+m6hgVCtlI/PcRL43f/tFwbq0LPwTU8nOTef89nkvdBaxDEJYHykrHpV4enAKctDulti
	bqEraanLn8/xdMxg8t1x0Yb1Ae8cvJXPVDOm8OW93fG+9CCOnr5oAwzyUmcky1YyulpGMt
	Y3ZrVeq8A+UrbUPGkFBdH2px5SViFe89cSWlsv7IEYy+Oi6FnZZft5BVyv3pk32Fg2hVIg
	MF6nCe/3lz4ykqfUrjm56nFDGgypnyzfWniDDvm8KATweCwOhnwHbMRI5CScNHs1Rv5UZa
	t33CIgs4s1bKrKugrXX0mLQvS3wF6Ivaq6XZ00ZHWTD2nNEpuOxXiKCYHq3zag==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1771933705;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=zAwsw+54U1JkBpviU3oyDxnbrMl/pdFkaDxG0Nxfr+M=;
	b=ggbLvw7GrYrS9Vu/g9B5g/0cmkIF2QKhHLxXIULUbS050F1C60XH6OsPHnWFBS4xpcnK+s
	n0qqGuJ0iZFrAHAg==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: Felix Maurer <fmaurer@redhat.com>, netdev@vger.kernel.org,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Richard Cochran <richardcochran@gmail.com>,
	Simon Horman <horms@kernel.org>
Subject: Re: [PATCH RFC net-next 0/2] hsr: Add additional info to send/
 receive skbs
Message-ID: <20260224114823.jgrNmhz_@linutronix.de>
References: <20260204-hsr_ptp-v1-0-b421c69a77da@linutronix.de>
 <aZNBfh81p1zBvbi2@thinkpad>
 <20260217161053.XMFBwFXg@linutronix.de>
 <aZYSvY8nUKhpLZhv@thinkpad>
 <willemdebruijn.kernel.10cafd56e9b48@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <willemdebruijn.kernel.10cafd56e9b48@gmail.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linutronix.de,none];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[linutronix.de:s=2020,linutronix.de:s=2020e];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-260491-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FREEMAIL_TO(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[redhat.com,vger.kernel.org,lunn.ch,davemloft.net,google.com,kernel.org,gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bigeasy@linutronix.de,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[linutronix.de:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,linutronix.de:mid,linutronix.de:dkim]
X-Rspamd-Queue-Id: CA4AF1869D1
X-Rspamd-Action: no action

On 2026-02-18 16:53:23 [-0500], Willem de Bruijn wrote:
> > I like the idea of putting the port hint in the ancillary data of the
> > message, but I'm not sure where to put in the skb then / how to pass it
> > to the hsr interface. Willem's suggestions are worth exploring I think.
> 
> Could you use existing SO_MARK? Optionally per packet with
> sock_cmsg_send. And use that in hsr_forward_do if set.
> 
> Or perhaps skb->queue_mapping. For instance with tc BPF, see commit
> 74e31ca850c1 ("bpf: add skb->queue_mapping write access from tc
> clsact").

So the idea is to replace the custom marking from userland with SO_MARK.
If SO_MARK is not conflicting with a possible classifier/ firewall rule
then I shouldn't have a problem switching to it. The content would be
fix however for the PORT_A/ PORT_B setting.

Thanks.

Sebastian

