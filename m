Return-Path: <netdev+bounces-26590-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 043D8778462
	for <lists+netdev@lfdr.de>; Fri, 11 Aug 2023 01:54:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 351911C20DF2
	for <lists+netdev@lfdr.de>; Thu, 10 Aug 2023 23:54:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8F7117AA4;
	Thu, 10 Aug 2023 23:54:39 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6F441877
	for <netdev@vger.kernel.org>; Thu, 10 Aug 2023 23:54:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 137E8C433C7;
	Thu, 10 Aug 2023 23:54:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1691711678;
	bh=uOWm0OuTUJi5tU6Ya2u7a1DLXtDQpZ1RRzcFooHrwRM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=gReWdooyI1QCQirItbGcLOIT5y1PsawzSqFA4J+i89sebo8MzLjYPOQRsE2WamK0n
	 RTiLxW0NhJXvnMHyzALYHSTA+gJBxA3Om5VsS9uzbGIEBcm7qzUOY3YSc91hNbZ6/N
	 M/R7iGaPTgPlhZ/Kg99+nY6yJ93JUfqsjysB8tpwYAzBRgJTAftl5m18YDc7KC3Zqj
	 2v48xadjakLVkqxVPMX42zSqq+i06LbgcSOqX1oGP2MA05gQst7EKczd7gOWwcjJt1
	 AiMe0guDOhcN1eH2ysb+GwgTN3Kmn+DeY1XiQplVbbEpQIqw3NAVRm8PeaVZqegkBz
	 WMW6Am3Yncqsg==
Date: Thu, 10 Aug 2023 16:54:37 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Aaron Conole <aconole@redhat.com>
Cc: Adrian Moreno <amorenoz@redhat.com>, netdev@vger.kernel.org,
 i.maximets@ovn.org, eric@garver.life, dev@openvswitch.org
Subject: Re: [net-next v4 1/7] net: openvswitch: add last-action drop reason
Message-ID: <20230810165437.0560ade1@kernel.org>
In-Reply-To: <f7tfs4q22ba.fsf@redhat.com>
References: <20230809153833.2363265-1-amorenoz@redhat.com>
	<20230809153833.2363265-2-amorenoz@redhat.com>
	<f7tfs4q22ba.fsf@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 10 Aug 2023 14:13:29 -0400 Aaron Conole wrote:
> I think they can be resolved in the same way the mac80211 drops are
> resolved by using (__force u32) to pass the reason argument.

Yup, preferably by creating a helper which takes enum ovs_drop_reason
and does the forcing, rather than annotating each call site, to state
the obvious perhaps.
-- 
pw-bot: cr

