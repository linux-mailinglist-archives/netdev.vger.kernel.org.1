Return-Path: <netdev+bounces-42228-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 72E747CDBC0
	for <lists+netdev@lfdr.de>; Wed, 18 Oct 2023 14:33:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A3FCC1C20D63
	for <lists+netdev@lfdr.de>; Wed, 18 Oct 2023 12:33:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9C482F522;
	Wed, 18 Oct 2023 12:33:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="EtUVbrp+"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33D1034CD7
	for <netdev@vger.kernel.org>; Wed, 18 Oct 2023 12:33:49 +0000 (UTC)
Received: from smtp-8fad.mail.infomaniak.ch (smtp-8fad.mail.infomaniak.ch [IPv6:2001:1600:3:17::8fad])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D28CA98
	for <netdev@vger.kernel.org>; Wed, 18 Oct 2023 05:33:47 -0700 (PDT)
Received: from smtp-3-0001.mail.infomaniak.ch (unknown [10.4.36.108])
	by smtp-2-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4S9VdQ4dmTzMqDh9;
	Wed, 18 Oct 2023 12:33:46 +0000 (UTC)
Received: from unknown by smtp-3-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4S9VdQ1gKtzMppBS;
	Wed, 18 Oct 2023 14:33:46 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=digikod.net;
	s=20191114; t=1697632426;
	bh=0vFTHivt8roguCC4mdmTk28ppnSwxwS/6gjbg//7wJo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=EtUVbrp+wKXDA6KiFthGUFPjom2SDHlrgQuhNE5bLRN6UkQY4ulR3EhmgRA4ClDxs
	 pvqaHZmTquADRNVCrryFEvSm1M/+TKHprHOgFj9u3JpUDGsjYXUN0na7hQOb6LcErV
	 i+NPSoBvK75zaAUcXnIFSyYPsW17+WhbtjEIbcbw=
Date: Wed, 18 Oct 2023 14:33:44 +0200
From: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
To: Konstantin Meskhidze <konstantin.meskhidze@huawei.com>
Cc: willemdebruijn.kernel@gmail.com, gnoack3000@gmail.com, 
	linux-security-module@vger.kernel.org, netdev@vger.kernel.org, netfilter-devel@vger.kernel.org, 
	yusongping@huawei.com, artem.kuzin@huawei.com
Subject: Re: [PATCH v13 11/12] samples/landlock: Add network demo
Message-ID: <20231018.ShoMiep0ixei@digikod.net>
References: <20231016015030.1684504-1-konstantin.meskhidze@huawei.com>
 <20231016015030.1684504-12-konstantin.meskhidze@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231016015030.1684504-12-konstantin.meskhidze@huawei.com>
X-Infomaniak-Routing: alpha
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Please update the subject to "samples/landlock: Support TCP restrictions"

On Mon, Oct 16, 2023 at 09:50:29AM +0800, Konstantin Meskhidze wrote:
> This commit adds network demo. It's possible to allow a sandboxer to
> bind/connect to a list of particular ports restricting network
> actions to the rest of ports.
> 
> Signed-off-by: Konstantin Meskhidze <konstantin.meskhidze@huawei.com>
> Link: https://lore.kernel.org/r/20230920092641.832134-12-konstantin.meskhidze@huawei.com
> [mic: Define __SANE_USERSPACE_TYPES__ to select int-ll64.h and avoid
> format warnings for PowerPC]

You can remove all this kind of "[mic: ]" comments, I add them when I
merge a patch with additional changes.

> Signed-off-by: Mickaël Salaün <mic@digikod.net>
> ---
> 
> Changes since v12:
> * Defines __SANE_USERSPACE_TYPES__ to avoid warnings for PowerPC.

