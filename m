Return-Path: <netdev+bounces-42223-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B6F17CDB9C
	for <lists+netdev@lfdr.de>; Wed, 18 Oct 2023 14:28:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C62D8B20F40
	for <lists+netdev@lfdr.de>; Wed, 18 Oct 2023 12:28:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE675347A3;
	Wed, 18 Oct 2023 12:28:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="py0lZkyh"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F8E43419C
	for <netdev@vger.kernel.org>; Wed, 18 Oct 2023 12:28:36 +0000 (UTC)
Received: from smtp-42a9.mail.infomaniak.ch (smtp-42a9.mail.infomaniak.ch [IPv6:2001:1600:3:17::42a9])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A7E5112
	for <netdev@vger.kernel.org>; Wed, 18 Oct 2023 05:28:34 -0700 (PDT)
Received: from smtp-2-0000.mail.infomaniak.ch (unknown [10.5.36.107])
	by smtp-2-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4S9VWN6SB9zMpnyK;
	Wed, 18 Oct 2023 12:28:32 +0000 (UTC)
Received: from unknown by smtp-2-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4S9VWN3LfdzMppDh;
	Wed, 18 Oct 2023 14:28:32 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=digikod.net;
	s=20191114; t=1697632112;
	bh=XLbZRMw4Qoxopp6BBhbSCSC9GK1oZ5vo3gS8znzlotU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=py0lZkyh9vcmSTPk0an7v1ye2el4ANTPJSB5h/r2L0Pf9+SY4IBzcXif+YM43nS69
	 2CGZUe9Q2dAFtWHQ9MXHdmM3idT0hjOl5xNUFhRfYceJaagurCV4dVoAZdKRyqdv/a
	 mkhOsNAlRgOKdHOrjvkWdy7MlQ0ytypcFIXrD7Uw=
Date: Wed, 18 Oct 2023 14:28:30 +0200
From: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
To: Konstantin Meskhidze <konstantin.meskhidze@huawei.com>
Cc: willemdebruijn.kernel@gmail.com, gnoack3000@gmail.com, 
	linux-security-module@vger.kernel.org, netdev@vger.kernel.org, netfilter-devel@vger.kernel.org, 
	yusongping@huawei.com, artem.kuzin@huawei.com
Subject: Re: [PATCH v13 01/12] landlock: Make ruleset's access masks more
 generic
Message-ID: <20231017.UXu7UP2ahree@digikod.net>
References: <20231016015030.1684504-1-konstantin.meskhidze@huawei.com>
 <20231016015030.1684504-2-konstantin.meskhidze@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20231016015030.1684504-2-konstantin.meskhidze@huawei.com>
X-Infomaniak-Routing: alpha
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Mon, Oct 16, 2023 at 09:50:19AM +0800, Konstantin Meskhidze wrote:
> To support network type rules, this modification renames ruleset's
> access masks and modifies it's type to access_masks_t. This patch
> adds filesystem helper functions to add and get filesystem mask.
> 
> Signed-off-by: Konstantin Meskhidze <konstantin.meskhidze@huawei.com>
> Link: https://lore.kernel.org/r/20230920092641.832134-2-konstantin.meskhidze@huawei.com

Please don't include Link that points to the previous patch series. I
add them when I apply a patch series to identify its source.

