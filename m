Return-Path: <netdev+bounces-52887-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FFB48008D3
	for <lists+netdev@lfdr.de>; Fri,  1 Dec 2023 11:46:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 66C021C20F70
	for <lists+netdev@lfdr.de>; Fri,  1 Dec 2023 10:46:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03D481D550;
	Fri,  1 Dec 2023 10:46:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Tmr5tUlC"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC3D510E5
	for <netdev@vger.kernel.org>; Fri,  1 Dec 2023 02:46:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1701427584;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6NA57GVpcAlUrYRXA0xtGWCe36ignqDZBMAU0zkJLz4=;
	b=Tmr5tUlC4HfHUjaFNEbVZRRKEHw38i9IChfW/WcvUFSLLjB7JiY6/hPKO/9FbWn/WvXgmR
	RAmlzHyBxjmQniGa7SpikcGX6uAdZrtLzekNSOH21PMKUPlygWeuYwJA39g3wBau2bXyx1
	ijUTG4lADMnDTpNZD5hnm0C8nSTQ1Yo=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-266-bWjaQz9HPTCrFgStonuXtQ-1; Fri,
 01 Dec 2023 05:46:20 -0500
X-MC-Unique: bWjaQz9HPTCrFgStonuXtQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 6AD7C3C0C127;
	Fri,  1 Dec 2023 10:46:19 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.39.193.68])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 12C8E10E46;
	Fri,  1 Dec 2023 10:46:16 +0000 (UTC)
From: Jose Ignacio Tornos Martinez <jtornosm@redhat.com>
To: stern@rowland.harvard.edu
Cc: davem@davemloft.net,
	edumazet@google.com,
	jtornosm@redhat.com,
	kuba@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-usb@vger.kernel.org,
	netdev@vger.kernel.org,
	oneukum@suse.com,
	pabeni@redhat.com
Subject: Re: [PATCH] net: usb: ax88179_178a: avoid failed operations when device is disconnected
Date: Fri,  1 Dec 2023 11:46:14 +0100
Message-ID: <20231201104615.173933-1-jtornosm@redhat.com>
In-Reply-To: <e8e4ac26-9168-452c-80bc-f32904808cc9@rowland.harvard.edu>
References: <e8e4ac26-9168-452c-80bc-f32904808cc9@rowland.harvard.edu>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.5

Hi Alan,

Thank you for your help.
    
> Another possibility would be to have the unbind routine set a flag in
> the private data structure, and then make the ax88179_write_cmd() and
> ax88179_read_cmd() routines avoid printing error messages if the flag is
> set.  Or don't bother with the flag, and simply make the routines skip
> printing an error message if a transfer fails with error code -ENODEV.

Yes, I had thought about those possibilities and I think they are the only
ones from the driver. As you are commenting as well, I will try a second
version with that.

Best regards
José Ignacio


