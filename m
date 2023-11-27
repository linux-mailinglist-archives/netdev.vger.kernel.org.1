Return-Path: <netdev+bounces-51224-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 158647F9C3E
	for <lists+netdev@lfdr.de>; Mon, 27 Nov 2023 10:04:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B55F01F207CE
	for <lists+netdev@lfdr.de>; Mon, 27 Nov 2023 09:04:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 178B910A24;
	Mon, 27 Nov 2023 09:04:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YFJP0TGh"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17EA912F
	for <netdev@vger.kernel.org>; Mon, 27 Nov 2023 01:04:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1701075859;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=piML3Mid1NWxeF+rFETYzTPt2JomB1OniMRw7lokn98=;
	b=YFJP0TGhx2eEhignO2WOE2KdNZ5XvJXhJpcM47x7bAXiT/VdNC6ICvnDUx9L8lxonLcMOA
	xviifeGyDLTDmR9E32GfCC2xEvIqMKZ6qVG45Z9AYGJDPAgdDKDupfvKDrclfs07lMlP0+
	EGk4ibc+CH1ixUOQK8R3IVuiCtJixP4=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-601-XqktnsTiM5WdgFevyW0t4Q-1; Mon,
 27 Nov 2023 04:04:15 -0500
X-MC-Unique: XqktnsTiM5WdgFevyW0t4Q-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 2E68D1C06EC9;
	Mon, 27 Nov 2023 09:04:15 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.161])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 20E47C1596F;
	Mon, 27 Nov 2023 09:04:14 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <20231122214447.675768-1-jannh@google.com>
References: <20231122214447.675768-1-jannh@google.com>
To: Jann Horn <jannh@google.com>
Cc: dhowells@redhat.com, Boris Pismenny <borisp@nvidia.com>,
    John Fastabend <john.fastabend@gmail.com>,
    Jakub Kicinski <kuba@kernel.org>,
    "David S.
 Miller" <davem@davemloft.net>, netdev@vger.kernel.org,
    linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] tls: fix NULL deref on tls_sw_splice_eof() with empty record
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1508420.1701075853.1@warthog.procyon.org.uk>
Date: Mon, 27 Nov 2023 09:04:13 +0000
Message-ID: <1508421.1701075853@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.8

Jann Horn <jannh@google.com> wrote:

> +	/* same checks as in tls_sw_push_pending_record() */

Wouldn't it be better to say what you're checking rather than referring off to
another function that might one day disappear or be renamed?

David


