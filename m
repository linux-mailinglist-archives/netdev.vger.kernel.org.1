Return-Path: <netdev+bounces-18652-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 47EE075836E
	for <lists+netdev@lfdr.de>; Tue, 18 Jul 2023 19:26:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7888C1C20CC5
	for <lists+netdev@lfdr.de>; Tue, 18 Jul 2023 17:26:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 394EC156DA;
	Tue, 18 Jul 2023 17:25:58 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AADD156CE
	for <netdev@vger.kernel.org>; Tue, 18 Jul 2023 17:25:57 +0000 (UTC)
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBCCA10CB;
	Tue, 18 Jul 2023 10:25:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=FovgKUTGpm6tXObmTmcd/1kMqMzEO6PvlbruapMG9ag=; b=rDWTViwFkSwGVXh3/EvCigz/me
	7TQA/jViEcKAmkYTwDmdXjDk3SGZTTMJMWQKBgvjue5v7i/JIZQzC21KQAfIzfJchEdRzCD45f13B
	GVm6eOrjBRSnauMQrH12ys9bjrs+lx+p5flbV4Qvhc0l8qM1VkgqhisVO0Ov/ZbCX5Zc=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1qLnyy-001diZ-4N; Tue, 18 Jul 2023 18:55:28 +0200
Date: Tue, 18 Jul 2023 18:55:28 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Jakub Kicinski <kuba@kernel.org>
Cc: corbet@lwn.net, workflows@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	gregkh@linuxfoundation.org, linux@leemhuis.info, broonie@kernel.org,
	krzk@kernel.org
Subject: Re: [PATCH docs v2] docs: maintainer: document expectations of small
 time maintainers
Message-ID: <25a50453-cbb6-4933-bb2f-79dfd2c76f9d@lunn.ch>
References: <20230718155814.1674087-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230718155814.1674087-1-kuba@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
	T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

> +Selecting the maintainer
> +========================
> +
> +The previous section described the expectations of the maintainer,
> +this section provides guidance on selecting one and decribes common

s/decribes/describes

> +Maintainers must be human, however, it is not acceptable to add a mailing
> +list or a group email as a maintainer.

I would probably replace however, with therefore. 

> +Removing an inactive maintainer should not be seen as a punitive action.
> +Having an inactive maintainer has a real cost as all developeres have

Too many e's in developeres

Otherwise:

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

