Return-Path: <netdev+bounces-37515-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 11BE17B5C03
	for <lists+netdev@lfdr.de>; Mon,  2 Oct 2023 22:26:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id BF3182813E0
	for <lists+netdev@lfdr.de>; Mon,  2 Oct 2023 20:26:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D99520307;
	Mon,  2 Oct 2023 20:26:54 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78979200D9
	for <netdev@vger.kernel.org>; Mon,  2 Oct 2023 20:26:52 +0000 (UTC)
Received: from smtp-190a.mail.infomaniak.ch (smtp-190a.mail.infomaniak.ch [IPv6:2001:1600:4:17::190a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F788B8
	for <netdev@vger.kernel.org>; Mon,  2 Oct 2023 13:26:50 -0700 (PDT)
Received: from smtp-3-0001.mail.infomaniak.ch (unknown [10.4.36.108])
	by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4Rzstd2zZxzMq8P9;
	Mon,  2 Oct 2023 20:26:49 +0000 (UTC)
Received: from unknown by smtp-3-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4Rzstc6pWCzMpp9v;
	Mon,  2 Oct 2023 22:26:48 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=digikod.net;
	s=20191114; t=1696278409;
	bh=FQO4GYtxljEfIaFZeQ1Y6yEZIrp0kicWALHfGDHmN0k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=AmroIdmZHCbvRmg5IsMg7QKReKE1dWoeCGFwiL1hHV9lt/MyfI7bUsAmj0N0diwLV
	 3PLZ286IUVxZeTgv+XVezY1PW32d6DiLA5AREY7pBBemZ/m/6esksvEAYWyMBXtKpa
	 nj5uOqseF2Rbn5jSOaJNAylyAJxc/fG/w17dBSRQ=
Date: Mon, 2 Oct 2023 22:26:48 +0200
From: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
To: Konstantin Meskhidze <konstantin.meskhidze@huawei.com>
Cc: willemdebruijn.kernel@gmail.com, gnoack3000@gmail.com, 
	linux-security-module@vger.kernel.org, netdev@vger.kernel.org, netfilter-devel@vger.kernel.org, 
	yusongping@huawei.com, artem.kuzin@huawei.com
Subject: Re: [PATCH v12 02/12] landlock: Allow filesystem layout changes for
 domains without such rule type
Message-ID: <20231001.lahkohr4pu4P@digikod.net>
References: <20230920092641.832134-1-konstantin.meskhidze@huawei.com>
 <20230920092641.832134-3-konstantin.meskhidze@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230920092641.832134-3-konstantin.meskhidze@huawei.com>
X-Infomaniak-Routing: alpha
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Please change the subject to "landlock: Allow FS topology changes for
domains without such rule type" to be consistent with the documentation.


On Wed, Sep 20, 2023 at 05:26:30PM +0800, Konstantin Meskhidze wrote:
> From: Mickaël Salaün <mic@digikod.net>
> 
> Allow mount point and root directory changes when there is no filesystem
> rule tied to the current Landlock domain.  This doesn't change anything
> for now because a domain must have at least a (filesystem) rule, but
> this will change when other rule types will come.  For instance, a
> domain only restricting the network should have no impact on filesystem
> restrictions.
> 
> Add a new get_current_fs_domain() helper to quickly check filesystem
> rule existence for all filesystem LSM hooks.
> 
> Remove unnecessary inlining.
> 
> Signed-off-by: Mickaël Salaün <mic@digikod.net>

