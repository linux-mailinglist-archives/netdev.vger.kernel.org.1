Return-Path: <netdev+bounces-13920-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 658CC73DF75
	for <lists+netdev@lfdr.de>; Mon, 26 Jun 2023 14:41:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7E0C81C208AF
	for <lists+netdev@lfdr.de>; Mon, 26 Jun 2023 12:41:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22B197483;
	Mon, 26 Jun 2023 12:41:40 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11C377F
	for <netdev@vger.kernel.org>; Mon, 26 Jun 2023 12:41:39 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B38CB10B
	for <netdev@vger.kernel.org>; Mon, 26 Jun 2023 05:41:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1687783297;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2BI3BrwEFe9opIuQ+xcZ5ZUrbV1COd1eadbq3gMAcfE=;
	b=Abeil8Ba+iEWAXB/g62RdpF3iwz5phkGQnGKH7zZZv8Opdv9GgXwQ72Sv2t/mY5G/cVXPP
	N+VDJTp6U1TtAgBEuhJY5BApONmI2w51BjVFq0yuci1ixquyaxG6fNl3eMVTGulJMzjXt+
	LrDb/rhDrD9Dh4cvNuSELcX7b0KmOPU=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-509-_KWxNDNpOCSURHiz4wAwlw-1; Mon, 26 Jun 2023 08:41:32 -0400
X-MC-Unique: _KWxNDNpOCSURHiz4wAwlw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 056FD800B35;
	Mon, 26 Jun 2023 12:41:32 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.39.192.192])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 03817F5AFB;
	Mon, 26 Jun 2023 12:41:28 +0000 (UTC)
From: Jose Ignacio Tornos Martinez <jtornosm@redhat.com>
To: jinjian.song@fibocom.com
Cc: Reid.he@fibocom.com,
	bjorn.helgaas@gmail.com,
	bjorn@helgaas.com,
	haijun.liu@mediatek.com,
	helgaas@kernel.org,
	jtornosm@redhat.com,
	kuba@kernel.org,
	netdev@vger.kernel.org,
	rafael.wang@fibocom.com,
	somashekhar.puttagangaiah@intel.com
Subject: Re: [v5,net-next]net: wwan: t7xx : V5 ptach upstream work
Date: Mon, 26 Jun 2023 14:41:27 +0200
Message-ID: <20230626124127.34719-1-jtornosm@redhat.com>
In-Reply-To: <SG2PR02MB3606473ED18C4A0F105A25B28C26A@SG2PR02MB3606.apcprd02.prod.outlook.com>
References: <SG2PR02MB3606473ED18C4A0F105A25B28C26A@SG2PR02MB3606.apcprd02.prod.outlook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.5
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
	T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Thanks Jinjian, you are right.
I will prepare a V2 patch with that update.

Jose Ignacio


