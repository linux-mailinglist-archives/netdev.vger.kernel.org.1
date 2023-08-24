Return-Path: <netdev+bounces-30426-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BC5878743F
	for <lists+netdev@lfdr.de>; Thu, 24 Aug 2023 17:32:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 73FAD1C20E95
	for <lists+netdev@lfdr.de>; Thu, 24 Aug 2023 15:32:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38D48134BB;
	Thu, 24 Aug 2023 15:32:04 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FD19100DC
	for <netdev@vger.kernel.org>; Thu, 24 Aug 2023 15:32:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7720EC43397;
	Thu, 24 Aug 2023 15:32:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1692891122;
	bh=shKzP6SBvNhyTSihnulA5HdvC9BRtYV2zw/VbcNU5Ko=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=tbuM6OCjxFAbOLwlHgkqVLhECtj93RdzE+sUtJJwhFGJ5GTDCg9pVcdSLNvcKG6fZ
	 bMwXOrY/LDcy2w6tNy/aFcL0sjCK6S1C+7t+drMeeOH5w9w138IXd/rghvBtKGSNSy
	 UnuxhP3CQ23CiA1SKDB6lrsRdcnVCV884n9655RZQOB9Jzz81i0k1H+LJjKrGEgqZ7
	 5/ng58DcSU/YH8hwzxVUoVM6qqFSH1qmxke7j/P+n5GYF4hiyMxumFg96XHFO3IRN8
	 z7IKFwCpX6MH8rWvNaUwd3fP05DK9a+rEZh4hAeqbSZQ4h3miIm4jyoP7PSKrAsPqO
	 hiQS2ezVAnipQ==
Date: Thu, 24 Aug 2023 08:32:01 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Wojciech Drewek <wojciech.drewek@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
 przemyslaw.kitszel@intel.com
Subject: Re: [PATCH iwl-next v2] ice: Disable Cage Max Power override
Message-ID: <20230824083201.79f79513@kernel.org>
In-Reply-To: <20230824085459.35998-1-wojciech.drewek@intel.com>
References: <20230824085459.35998-1-wojciech.drewek@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 24 Aug 2023 10:54:59 +0200 Wojciech Drewek wrote:
> NVM module called "Cage Max Power override" allows to
> change max power in the cage. This can be achieved
> using external tools. The responsibility of the ice driver is to
> go back to the default settings whenever port split is done.
> This is achieved by clearing Override Enable bit in the
> NVM module. Override of the max power is disabled so the
> default value will be used.

Can you say more? We have ETHTOOL_MSG_MODULE_GET / SET, sounds like
something we could quite easily get ethtool to support?

