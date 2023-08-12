Return-Path: <netdev+bounces-27067-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BA2477A187
	for <lists+netdev@lfdr.de>; Sat, 12 Aug 2023 19:53:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5E2F61C20905
	for <lists+netdev@lfdr.de>; Sat, 12 Aug 2023 17:53:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC3DB8BE3;
	Sat, 12 Aug 2023 17:53:10 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD1E38839
	for <netdev@vger.kernel.org>; Sat, 12 Aug 2023 17:53:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DBF75C433C8;
	Sat, 12 Aug 2023 17:53:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1691862789;
	bh=gDFwiP1m0fKyKMgA4o0QJNJuPAPe4CNCLkLEAlRxL/0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=a88O3yT9Eb7KYYhxCJVHpyDdqiqj6bc5Tyg12kgIsFxDNCainXZgzzPX9Zm0LKyL3
	 bzq0VFBL1468P7+t7uT903tLlMHN1Tkcwnz0r2nnBAYrrht9FGwnopxuNVXs7WRoKP
	 R4VQHBemH8nyiCA0mAVJZlG1bxHW2lJlj6ZdZCiqfHrwMHQ2TQS8sKeV3tKqoieBct
	 HKaZdEaqLoec+lbq/8yfsHWtQaO4V9obLi5IES20jVqEb2ohF4249rtA3RXw/hX/ra
	 hDRUBXeshSvNOsPW5qwPrCo7xF6v2+le6S1AZ7XblM/cW+nI6QFacLEPAa6ox8WzIB
	 UJH9qtDtj/EKg==
Date: Sat, 12 Aug 2023 19:53:05 +0200
From: Simon Horman <horms@kernel.org>
To: =?utf-8?Q?J=C3=B6rn-Thorben?= Hinz <jthinz@mailbox.tu-berlin.de>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH net-next] net: Remove leftover include from nftables.h
Message-ID: <ZNfHAbz+LMqhi9oq@vergenet.net>
References: <20230811173357.408448-1-jthinz@mailbox.tu-berlin.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230811173357.408448-1-jthinz@mailbox.tu-berlin.de>

On Fri, Aug 11, 2023 at 07:33:57PM +0200, Jörn-Thorben Hinz wrote:
> Commit db3685b4046f ("net: remove obsolete members from struct net")
> removed the uses of struct list_head from this header, without removing
> the corresponding included header.
> 
> Signed-off-by: Jörn-Thorben Hinz <jthinz@mailbox.tu-berlin.de>

Reviewed-by: Simon Horman <horms@kernel.org>


