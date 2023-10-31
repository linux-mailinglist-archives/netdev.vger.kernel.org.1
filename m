Return-Path: <netdev+bounces-45421-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D5AEB7DCD35
	for <lists+netdev@lfdr.de>; Tue, 31 Oct 2023 13:50:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 879E228158D
	for <lists+netdev@lfdr.de>; Tue, 31 Oct 2023 12:50:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C82515CA;
	Tue, 31 Oct 2023 12:50:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19EE1A29
	for <netdev@vger.kernel.org>; Tue, 31 Oct 2023 12:50:35 +0000 (UTC)
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28D29BD;
	Tue, 31 Oct 2023 05:50:34 -0700 (PDT)
Received: from smtp1.mailbox.org (smtp1.mailbox.org [10.196.197.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4SKVNh3YBSz9srd;
	Tue, 31 Oct 2023 13:50:28 +0100 (CET)
Message-ID: <ddd10375-ac56-4fed-821f-546f0642ccab@v0yd.nl>
Date: Tue, 31 Oct 2023 13:50:24 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
To: josephsih@chromium.org
Cc: chromeos-bluetooth-upstreaming@chromium.org, davem@davemloft.net,
 edumazet@google.com, johan.hedberg@gmail.com, josephsih@google.com,
 kuba@kernel.org, linux-bluetooth@vger.kernel.org,
 linux-kernel@vger.kernel.org, luiz.dentz@gmail.com, marcel@holtmann.org,
 netdev@vger.kernel.org, pabeni@redhat.com, pali@kernel.org
References: <20220526112135.2486883-1-josephsih@chromium.org>
Subject: Re: [PATCH v6 1/5] Bluetooth: mgmt: add MGMT_OP_SET_QUALITY_REPORT
 for quality report
Content-Language: en-US
From: =?UTF-8?Q?Jonas_Dre=C3=9Fler?= <verdre@v0yd.nl>
In-Reply-To: <20220526112135.2486883-1-josephsih@chromium.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Joseph,

gentle ping about this one, are you still planning to propose a v7 here?

Regards,
Jonas

