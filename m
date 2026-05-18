Return-Path: <netdev+bounces-288865-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ABciEoKzCmpx5wQAu9opvQ
	(envelope-from <netdev+bounces-288865-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 18 May 2026 08:36:50 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CAF65566C5F
	for <lists+netdev@lfdr.de>; Mon, 18 May 2026 08:36:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A51D7306C364
	for <lists+netdev@lfdr.de>; Mon, 18 May 2026 06:28:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58C333DEFFC;
	Mon, 18 May 2026 06:28:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b="F58nGVy5"
X-Original-To: netdev@vger.kernel.org
Received: from mx1.secunet.com (mx1.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDBED3DA7C2;
	Mon, 18 May 2026 06:28:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.96.220.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779085693; cv=none; b=s/dWf2yqTnnGjzXWk0Kfi+e9xyW+xAiXGylYFussUWatEgYDUE5rncujLWBuxoyiTZeMvrV7R8pRoM79tzkyiJUzVdsz4xj9ODxPDwD5DD6FELcq3vuK5QFudLh5IIchpvX17hsMCvh/lDUwRzFHB77hlycRlYS70/e3OziKwrw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779085693; c=relaxed/simple;
	bh=SJ5gLLVxJOakoUNOMgrCNWxQ83NxGMy+ViwfNNE40As=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QZidMmqqqRpw4sMuWP63LL4ZcFAOE4ViwXT0arAewNRlFdua7C63AU5U1FmX56jlZcAj76ZJzDDa2smUOKTfZ+CG+kioIgmuSakr5nYCBBOsIFISad0Pun15zqjilqSkSk8suvEY7XU7EDf2zjPiBDUoWKGDNE6GDmmn/ncNbcQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secunet.com; spf=pass smtp.mailfrom=secunet.com; dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b=F58nGVy5; arc=none smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secunet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=secunet.com
Received: from localhost (localhost [127.0.0.1])
	by mx1.secunet.com (Postfix) with ESMTP id C8426205ED;
	Mon, 18 May 2026 08:27:58 +0200 (CEST)
X-Virus-Scanned: by secunet
Received: from mx1.secunet.com ([127.0.0.1])
 by localhost (mx1.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Bmag_DWrwKnk; Mon, 18 May 2026 08:27:58 +0200 (CEST)
Received: from EXCH-01.secunet.de (rl1.secunet.de [10.32.0.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.secunet.com (Postfix) with ESMTPS id 4B4B5205CF;
	Mon, 18 May 2026 08:27:58 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.secunet.com 4B4B5205CF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=secunet.com;
	s=202301; t=1779085678;
	bh=6Zxuse8e/Qj81PjLK5on0GALjOLIFUOCpbtSU25P1H0=;
	h=Date:From:To:CC:Subject:References:In-Reply-To:From;
	b=F58nGVy5sY1f6CX6M14+tkIVXFto7Y4uPZGxvG/abL4Wwk0zlRhRxAgL2H5JD6h/I
	 YdvKF/ZHhQJkmSw2iklkG1ROUgfYSjSod8nMDE9w9fMeDdFqZUGSKFIrUT3XSJ03+B
	 JU9YqFZm7uXMA7s+S583mN4ZLfUPi8YauNSAIvh9rzbYUXEbrhqJaq8EjGz0P8d6N6
	 9lHtQAB3uKB3bJttbuv0OfABKWCDAaOeq5+27PNTX18yxVOz1AsApGQ3RobuJwFEHs
	 1wUqRk1I5yFOLXAqdN2PcDiipcTA8CCOLG9i3rVUrOLIW2OBGGoEY772TANm1C6738
	 P9OVHxLgA9L2Q==
Received: from secunet.com (10.182.7.193) by EXCH-01.secunet.de (10.32.0.171)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Mon, 18 May
 2026 08:27:57 +0200
Received: (nullmailer pid 2860875 invoked by uid 1000);
	Mon, 18 May 2026 06:27:57 -0000
Date: Mon, 18 May 2026 08:27:57 +0200
From: Steffen Klassert <steffen.klassert@secunet.com>
To: =?iso-8859-1?Q?G=FCnther?= Muller <gunther.muller2008@gmail.com>
CC: <herbert@gondor.apana.org.au>, <davem@davemloft.net>,
	<edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] xfrm: fix missing headroom check in
 xfrm_dev_direct_output
Message-ID: <agqxbZTZk99GiWlF@secunet.com>
References: <20260517111940.8987-1-gunther.muller2008@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260517111940.8987-1-gunther.muller2008@gmail.com>
X-ClientProxiedBy: EXCH-01.secunet.de (10.32.0.171) To EXCH-01.secunet.de
 (10.32.0.171)
X-Rspamd-Queue-Id: CAF65566C5F
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[secunet.com,none];
	R_DKIM_ALLOW(-0.20)[secunet.com:s=202301];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,secunet.com:mid,secunet.com:dkim];
	TAGGED_FROM(0.00)[bounces-288865-lists,netdev=lfdr.de];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[secunet.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[steffen.klassert@secunet.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[8];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Action: no action

On Sun, May 17, 2026 at 01:19:40PM +0200, Günther Muller wrote:
> Ensure the skb has enough headroom for the hardware offload device's
> hard_header_len. If the headroom is insufficient (e.g., when routing
> through certain virtual or tunnel devices), __skb_push() underflows
> skb->data below skb->head, causing silent memory corruption.
> 
> Fix this by using skb_cow_head() to dynamically expand headroom if
> needed, and switch to the checked skb_push() variant.
> 
> Signed-off-by: Günther Muller <gunther.muller2008@gmail.com>

As this is a fix, please add a 'Fixes:' tag to the commit message.

Thanks!

