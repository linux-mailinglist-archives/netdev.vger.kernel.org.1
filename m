Return-Path: <netdev+bounces-29684-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 72F13784530
	for <lists+netdev@lfdr.de>; Tue, 22 Aug 2023 17:13:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2BB7D281104
	for <lists+netdev@lfdr.de>; Tue, 22 Aug 2023 15:13:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E00941D307;
	Tue, 22 Aug 2023 15:12:58 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4EF61FD0
	for <netdev@vger.kernel.org>; Tue, 22 Aug 2023 15:12:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CCB7CC433C7;
	Tue, 22 Aug 2023 15:12:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1692717177;
	bh=SDTz5ot6TCb02ZDMISMKb+snwaqJ5DTq12W2yyBuf38=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=jADm5rj0BUxJdpJEZeOBC/lvTE585n4ykOkZs7/TvcOXdl35W2CAYPk15xRMDj9aX
	 RfKaOl4qN6VHAsKO70+0J+zRLcfZUwYyVQZXuVxzPkBRb56UTEX6yLC7R2VKoX7Ii3
	 Mr1JBSifFsR4uEL61cJdQFF9FloTrc1oNyslGPIz+1Bbwo5swxe+bu/2tc148uQ58t
	 ggi3E6CbMe9xfXDzF0A6CmcA7GMTCg3BOxnyt6S5vUdy7y03rHbOi9bT6yeC0CM7OX
	 TPAIAeDNowtAEzNf4KtOivvbaGtgVOdLg3FaXjYSVqX1ZfkvQyL1DEZGMLSTUJ/LvY
	 qUlfBLmHfyoVw==
Date: Tue, 22 Aug 2023 08:12:55 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Jiri Pirko <jiri@resnulli.us>
Cc: Wenjun Wu <wenjun1.wu@intel.com>, intel-wired-lan@lists.osuosl.org,
 netdev@vger.kernel.org, xuejun.zhang@intel.com, madhu.chittim@intel.com,
 qi.z.zhang@intel.com, anthony.l.nguyen@intel.com
Subject: Re: [PATCH iwl-next v4 0/5] iavf: Add devlink and devlink rate
 support
Message-ID: <20230822081255.7a36fa4d@kernel.org>
In-Reply-To: <ZORRzEBcUDEjMniz@nanopsycho>
References: <20230727021021.961119-1-wenjun1.wu@intel.com>
	<20230822034003.31628-1-wenjun1.wu@intel.com>
	<ZORRzEBcUDEjMniz@nanopsycho>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 22 Aug 2023 08:12:28 +0200 Jiri Pirko wrote:
> NACK! Port function is there to configure the VF/SF from the eswitch
> side. Yet you use it for the configureation of the actual VF, which is
> clear misuse. Please don't

Stating where they are supposed to configure the rate would be helpful.

