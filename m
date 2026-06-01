Return-Path: <netdev+bounces-293588-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KHjWFaczHWoqWQkAu9opvQ
	(envelope-from <netdev+bounces-293588-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 01 Jun 2026 09:24:23 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A9C7261AD09
	for <lists+netdev@lfdr.de>; Mon, 01 Jun 2026 09:24:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6CE7A304A93C
	for <lists+netdev@lfdr.de>; Mon,  1 Jun 2026 07:14:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F235F38333E;
	Mon,  1 Jun 2026 07:14:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b="TSigyGnc"
X-Original-To: netdev@vger.kernel.org
Received: from mx1.secunet.com (mx1.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAB843314B9;
	Mon,  1 Jun 2026 07:14:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.96.220.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780298067; cv=none; b=aDS6lHnQBivSg0cGGKwmoCFyJwxyIZmuNJe2mTCcgzWN2VvOvsA4Q2fp/3uznkuwlYi1kZHJSHMPZHOFj8FIKYtZp0qZI55wicJ0zSSAZTSC9LnbI3Q7IiFAU6o5wpo19IbAcCMizYFjEe+SYb2Jzu8n+iueQ5EI1AvObgWrvrc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780298067; c=relaxed/simple;
	bh=MQwfcj1z/UtX/NPyQTZ9n9JesGHpwsIUTha+9Ml5HZk=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L+S+Gi5nqU0dgwdhdSo0YEBjZW70VU1ylb0GmbuLUtCuuJagrSrzBcL914rxyNdql6z5I+Bvn99wk/3PERcpqi5AAdrxLYgeG4MqbFVk6qbn0fZN61oGmKjL5qpXfdSoeNm5MZ5PiBKFkAhcTf4DLcs42zT79kHPs8DnTbXoUTc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secunet.com; spf=pass smtp.mailfrom=secunet.com; dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b=TSigyGnc; arc=none smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secunet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=secunet.com
Received: from localhost (localhost [127.0.0.1])
	by mx1.secunet.com (Postfix) with ESMTP id 2C79020704;
	Mon,  1 Jun 2026 09:14:24 +0200 (CEST)
X-Virus-Scanned: by secunet
Received: from mx1.secunet.com ([127.0.0.1])
 by localhost (mx1.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id TFRZOm4DRHN5; Mon,  1 Jun 2026 09:14:23 +0200 (CEST)
Received: from EXCH-01.secunet.de (rl1.secunet.de [10.32.0.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.secunet.com (Postfix) with ESMTPS id A4789206B0;
	Mon,  1 Jun 2026 09:14:23 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.secunet.com A4789206B0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=secunet.com;
	s=202301; t=1780298063;
	bh=KpFZQlGb/16HVTjMY09rig/HHtsjnSRuWOZla/u0Lw8=;
	h=Date:From:To:CC:Subject:References:In-Reply-To:From;
	b=TSigyGnc2jtgLJSdPlWiWaG5vVIcDP/NHJrryqS3NTJd5i3u6wNqiwPpFIkeo1z4B
	 5tuezTNa1Xytai1QJ2WhEIeQdNKGA0coHNWq5myumL8+35Xb5hO3cPTMapXazFq4FL
	 H1l4892dPHuK0flvIPkWjwwpiNYjW0kH02eZeoE+yeMFXAsP5Matv8yPd2C5i1j8HW
	 tTcSkRjwssAh++sP/PZYVVTjvNOzcMyry4SMo5wHnlLgqinafPSfDZhkZTUvoLEkhu
	 r/oPFAnaX0gucaxMe1FlkuyZbKaK4/NsYh07UbUEmDIkvBCyrG8fUhXpSsfP5hBdch
	 CyaUvje3aIZvw==
Received: from secunet.com (10.182.7.193) by EXCH-01.secunet.de (10.32.0.171)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Mon, 1 Jun
 2026 09:14:22 +0200
Received: (nullmailer pid 3271774 invoked by uid 1000);
	Mon, 01 Jun 2026 07:14:21 -0000
Date: Mon, 1 Jun 2026 09:14:21 +0200
From: Steffen Klassert <steffen.klassert@secunet.com>
To: Alessandro Schino <7991aleschino@gmail.com>
CC: <netdev@vger.kernel.org>, <herbert@gondor.apana.org.au>,
	<davem@davemloft.net>, <pabeni@redhat.com>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH ipsec] esp: fix uninitialised req->src dereference in
 esp_ssg_unref
Message-ID: <ah0xTcyASTweURna@secunet.com>
References: <20260529071847.1301-1-7991aleschino@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260529071847.1301-1-7991aleschino@gmail.com>
X-ClientProxiedBy: EXCH-03.secunet.de (10.32.0.183) To EXCH-01.secunet.de
 (10.32.0.171)
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[secunet.com,none];
	R_DKIM_ALLOW(-0.20)[secunet.com:s=202301];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-293588-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[secunet.com:+];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[steffen.klassert@secunet.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: A9C7261AD09
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, May 29, 2026 at 09:18:46AM +0200, Alessandro Schino wrote:
> When esp_ssg_unref() is called with already_unref=true, req->src has
> not been initialised yet because aead_request_set_crypt() has not been
> called at that point. Use esp_req_sg() to obtain the source scatterlist
> directly from the tmp buffer layout instead.
> 
> Fixes: 2982e599fff6 ("esp: fix page frag reference leak on skb_to_sgvec failure")
> Signed-off-by: Alessandro Schino <7991aleschino@gmail.com>

Please resend the full fixed patch on top of the ipsec tree.

