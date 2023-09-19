Return-Path: <netdev+bounces-34854-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 93AB07A57D4
	for <lists+netdev@lfdr.de>; Tue, 19 Sep 2023 05:19:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4ED96281358
	for <lists+netdev@lfdr.de>; Tue, 19 Sep 2023 03:19:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEB3D34187;
	Tue, 19 Sep 2023 03:19:18 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4B13180;
	Tue, 19 Sep 2023 03:19:15 +0000 (UTC)
Received: from core.lopingdog.com (core.lopingdog.com [162.55.228.84])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FC0810E;
	Mon, 18 Sep 2023 20:19:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lopingdog.com;
	s=mail; t=1695093552;
	bh=7bVHNdcpaHpCFEna/MIK8KvjKex0U/8cfhWm/DIBQiA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MG/UxRcGxgHBjbMWFFx6damvZVR00dlUdv6vMki7EDUTZPSZHTmWLH4uAAiCfnHK9
	 Q8sOG0HuYtobmdCXQafmKrJYSAMldPwPvbtOdvwwkT7iTpmoh3icjYBd3iB42v2C+G
	 Y0Gx3/0+6zYSRk2wVdYmsAdNmDu+ryUxwNuUAwsT6v2aErdBn4d6PG5b6/PqBW+g4n
	 7nMVrheJ+c+xuJQnpTOfjMcFpU5/jlaGgMFOpCETSjCGNXIbOcAS/+2MWcY9jAyji/
	 q0fvYS1HW3SMhoMxM0dE1xHlui1Eyzs56cxU2084CRaB34AqxzrUaPHWZu+tDcC78A
	 c8COUBTh+s4KA==
Received: from authenticated-user (core.lopingdog.com [162.55.228.84])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by core.lopingdog.com (Postfix) with ESMTPSA id CE53E4402D7;
	Mon, 18 Sep 2023 22:19:11 -0500 (CDT)
Date: Mon, 18 Sep 2023 22:19:10 -0500
From: Jay Monkman <jtm@lopingdog.com>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: devicetree@vger.kernel.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Piergiorgio Beruto <piergiorgio.beruto@gmail.com>,
	Arndt Schuebel <Arndt.Schuebel@onsemi.com>
Subject: Re: [PATCH 2/4] dt-bindings: net: Add onsemi NCN26010 ethernet
 controller
Message-ID: <ZQkTLmi5VtxczYLs@lopingdog.com>
References: <ZQf1Mgb8lfHkB6rl@lopingdog.com>
 <5194bd75-9562-8375-5748-ccce560b67cf@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5194bd75-9562-8375-5748-ccce560b67cf@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Mon, Sep 18, 2023 at 10:28:47PM +0200, Krzysztof Kozlowski wrote:

> Please use scripts/get_maintainers.pl to get a list of necessary people
> and lists to CC (and consider --no-git-fallback argument). It might
> happen, that command when run on an older kernel, gives you outdated
> entries. Therefore please be sure you base your patches on recent Linux
> kernel.

Will do. Thanks for your other comments - I've got some work to do.

Jay


