Return-Path: <netdev+bounces-274625-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +GWSKGOczmnfowYAu9opvQ
	(envelope-from <netdev+bounces-274625-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 02 Apr 2026 18:42:11 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E62038C158
	for <lists+netdev@lfdr.de>; Thu, 02 Apr 2026 18:42:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 1FEE93126BBC
	for <lists+netdev@lfdr.de>; Thu,  2 Apr 2026 16:33:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60D213EC2D7;
	Thu,  2 Apr 2026 16:32:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="eMOhEyPT";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="6AqVCuFc"
X-Original-To: netdev@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07EC63F54BE
	for <netdev@vger.kernel.org>; Thu,  2 Apr 2026 16:32:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775147562; cv=none; b=uJSZ85s1EGnMlD7xfuZXDGTv+AvcwASB2XWm3LmVKEVg6PpUcbLX7RdGCAyaP3sIGOwpA8K6E/ASOAXAkPtRD96KCkGl9LL3uV1ogxUZfmB9Xod5VHvTT0BxTKF+968jGQyBALEQidiiQRTUMGEKWvDsqaEx9oNTjk3Q2Doa8ro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775147562; c=relaxed/simple;
	bh=JR2o/Dc9KQQqFMs2hnW304fAynwgXnuFy/EOByn52Nw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TXnpKf72zDkvXtdTbPeEsT6txYtLUwCcpe0GUJUj3YeXo4oBPb9H/J5BnUZE5x60VJC8pQTO3Kv8lre7tO2xU+bQNx1JSWpO3zO9xdOFVvcHmPJwlBeoqhFLMrnb6kZfOMHHLcMCtOxLhWH+ZwdJPBWnVmp23qAyLdP26mRcC8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=eMOhEyPT; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=6AqVCuFc; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 2 Apr 2026 18:32:37 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1775147559;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JR2o/Dc9KQQqFMs2hnW304fAynwgXnuFy/EOByn52Nw=;
	b=eMOhEyPTU45GkNf/h1IYQsQon69FNInXZ4/egJiqsaby0sSkT0r9cUIx8DmMVQu4icudbG
	71Vl7qMm7zXTtLXkKpEo1wlUEpDkZnmOxmebPUrfpXnupboSeDZQEjH3LP1MpHjfQRN2iC
	oo66MXpiAqq6Q+WVN49mowhgQsL3IOkd3cLmYYzDqMDYFq1tUj6x7dJ7ABmI2rF8VD3bU7
	d1Vagd7r099xSMJNkrFA6rnyEkYf013CPmWyPNMQTqhnYJtOE/3HXHAsyqtKA2CvnfRDEA
	qgKV86mG2h649kHXOmWPqcAnA/3Akf9JWF5eCeriKJCucGX6s8L+XMGdhPwMXg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1775147559;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JR2o/Dc9KQQqFMs2hnW304fAynwgXnuFy/EOByn52Nw=;
	b=6AqVCuFcgm8NfkvkcuFzT+6kOyfZDv460at6EMrCJkrv7U4omptslPzMFsro2W2Y4zBCvx
	UkDaiYTCIzaLE/BQ==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: netdev@vger.kernel.org, "(JC), Jayachandran" <j-rameshbabu@ti.com>,
	"David S. Miller" <davem@davemloft.net>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Chintan Vankar <c-vankar@ti.com>, Danish Anwar <danishanwar@ti.com>,
	Daolin Qiu <d-qiu@ti.com>, Eric Dumazet <edumazet@google.com>,
	Felix Maurer <fmaurer@redhat.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Richard Cochran <richardcochran@gmail.com>,
	Simon Horman <horms@kernel.org>,
	"Raghavendra, Vignesh" <vigneshr@ti.com>,
	"Bajjuri, Praneeth" <praneeth@ti.com>,
	"TK, Pratheesh Gangadhar" <pratheesh@ti.com>,
	"Muralidharan, Neelima" <neelima@ti.com>
Subject: Re: [PATCH RFC net-next v2 2/2] af_packet: Add port specific
 handling for HSR
Message-ID: <20260402163237.EIE16Pj_@linutronix.de>
References: <20260312154253.UC-QUPvD@linutronix.de>
 <willemdebruijn.kernel.be379ee17449@gmail.com>
 <20260313092226.SscHp2zQ@linutronix.de>
 <20260313160410.LEhav8Xz@linutronix.de>
 <willemdebruijn.kernel.1fbf050c50d62@gmail.com>
 <20260317172906.eG2LxlZ7@linutronix.de>
 <willemdebruijn.kernel.17068ce38efa5@gmail.com>
 <20260319142613.KHz32I-V@linutronix.de>
 <willemdebruijn.kernel.8e323262df61@gmail.com>
 <20260324163820.p9M2z27W@linutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20260324163820.p9M2z27W@linutronix.de>
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linutronix.de,none];
	R_DKIM_ALLOW(-0.20)[linutronix.de:s=2020,linutronix.de:s=2020e];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-274625-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[18];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[vger.kernel.org,ti.com,davemloft.net,lunn.ch,google.com,redhat.com,kernel.org,gmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bigeasy@linutronix.de,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[linutronix.de:+];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,linutronix.de:dkim,linutronix.de:mid]
X-Rspamd-Queue-Id: 1E62038C158
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Willem,

On 2026-03-24 17:38:21 [+0100], To Willem de Bruijn wrote:
> On 2026-03-19 12:27:57 [-0400], Willem de Bruijn wrote:
> >=20
> > Right, so this is simple without hardware offload. Does this HW
> > offload exist, or is this aspirational. At least for infrequent PTP
> > it does not sound important.
>=20
> The snippet below was for the icssg driver as-is and it works with
> updated firmware to ignore PTP packets while HW offloading is enabled.
=E2=80=A6
> With the skb_ext I had, the mechanism was mostly the same but it relied
> only on the skb_ext data. Now it has to look at skb->mark.

Had you so time think about it? The proposed skb->mark solution kind of
works but feels hacky.
The version with skb_ext does touch packet's code but it is self
contained and does not slowdown the !HSR+PTP case since the compare
conditions are NOPed.
How do we move forward here?
=20
Sebastian

