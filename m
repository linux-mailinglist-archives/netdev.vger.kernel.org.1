Return-Path: <netdev+bounces-23201-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C956676B4CC
	for <lists+netdev@lfdr.de>; Tue,  1 Aug 2023 14:32:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 057B31C20EA0
	for <lists+netdev@lfdr.de>; Tue,  1 Aug 2023 12:32:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B5642515E;
	Tue,  1 Aug 2023 12:32:16 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90A502515A
	for <netdev@vger.kernel.org>; Tue,  1 Aug 2023 12:32:15 +0000 (UTC)
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2007210C7;
	Tue,  1 Aug 2023 05:32:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=BcDG6kyS+7oOi8McT/e1cBfxl2o1BolNq+/zXfE9QMM=; b=U3HEPI+50Unc8zQq9w7d+RM/m1
	bsORfna6VAaa0YgAIFBSxNTtImLm1NJKrPUys4CyIoGdFKwn4OTRLkvcCEHvZjziz25FyjIixzkPA
	IPSThWh98lDcVISgC/v+SIWoG56O0RbhCy/TMw0VOLSDB/TmzDSvhBV2ExEX+4KcoVIU=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1qQoXa-002njw-JF; Tue, 01 Aug 2023 14:31:54 +0200
Date: Tue, 1 Aug 2023 14:31:54 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Anvesh Jain P <quic_ajainp@quicinc.com>
Cc: "David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <simon.horman@corigine.com>,
	Kuniyuki Iwashima <kuniyu@amazon.com>,
	Hangbin Liu <liuhangbin@gmail.com>, Jiri Pirko <jiri@resnulli.us>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Andy Ren <andy.ren@getcruise.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Venkata Rao Kakani <quic_vkakani@quicinc.com>,
	Vagdhan Kumar <quic_vagdhank@quicinc.com>
Subject: Re: [PATCH] net: export dev_change_name function
Message-ID: <447ba1fe-b20b-4ed0-97bc-4137b2ccfb37@lunn.ch>
References: <20230801112101.15564-1-quic_ajainp@quicinc.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230801112101.15564-1-quic_ajainp@quicinc.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
	T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Tue, Aug 01, 2023 at 04:51:01PM +0530, Anvesh Jain P wrote:
> export dev_change_name function to be used by other modules.
> 
> Signed-off-by: Vagdhan Kumar <quic_vagdhank@quicinc.com>
> Signed-off-by: Anvesh Jain P <quic_ajainp@quicinc.com>

It would be normal to include a user of the API when exposing an API.

What module needs to change the name of a device? At the moment, only
user space can do this via netlink or an IOCTL.

     Andrew

