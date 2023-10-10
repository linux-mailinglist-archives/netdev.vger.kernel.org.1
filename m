Return-Path: <netdev+bounces-39579-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D78387BFF2E
	for <lists+netdev@lfdr.de>; Tue, 10 Oct 2023 16:26:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9B8B22818F3
	for <lists+netdev@lfdr.de>; Tue, 10 Oct 2023 14:26:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0627424C9D;
	Tue, 10 Oct 2023 14:26:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69C6724C7B
	for <netdev@vger.kernel.org>; Tue, 10 Oct 2023 14:26:42 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by lindbergh.monkeyblade.net (Postfix) with ESMTP id CA3BB91;
	Tue, 10 Oct 2023 07:26:39 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4F9B61FB;
	Tue, 10 Oct 2023 07:27:20 -0700 (PDT)
Received: from e125770.cambridge.arm.com (e125770.arm.com [10.1.199.1])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id ABF193F762;
	Tue, 10 Oct 2023 07:26:38 -0700 (PDT)
From: Luca Fancellu <luca.fancellu@arm.com>
To: linux-kernel@vger.kernel.org
Cc: Wei Liu <wei.liu@kernel.org>,
	Paul Durrant <paul@xen.org>,
	xen-devel@lists.xenproject.org,
	netdev@vger.kernel.org,
	Rahul Singh <rahul.singh@arm.com>
Subject: [PATCH 0/1] Add software timestamp capabilities to xen-netback device
Date: Tue, 10 Oct 2023 15:26:29 +0100
Message-Id: <20231010142630.984585-1-luca.fancellu@arm.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
	SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hi all,

during some experiment using PTP (ptp4l) between a Dom0 domain and a DomU guest,
I noticed that the virtual interface brought up by the toolstack was not able
to be used as ptp4l interface on the Dom0 side, a brief investigation on the
drivers revealed that the backend driver doesn't have the SW timestamp
capabilities, so in order to provide them, I'm sending this patch.

Luca Fancellu (1):
  xen-netback: add software timestamp capabilities

 drivers/net/xen-netback/interface.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)


base-commit: cb0856346a60fe3eb837ba5e73588a41f81ac05f
-- 
2.34.1


