Return-Path: <netdev+bounces-24633-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 45F6F770E51
	for <lists+netdev@lfdr.de>; Sat,  5 Aug 2023 09:19:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 712DE1C20A8C
	for <lists+netdev@lfdr.de>; Sat,  5 Aug 2023 07:19:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43221538B;
	Sat,  5 Aug 2023 07:19:45 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35E9233C1
	for <netdev@vger.kernel.org>; Sat,  5 Aug 2023 07:19:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91884C433C7;
	Sat,  5 Aug 2023 07:19:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1691219984;
	bh=fbPzXbOWYywTJpG5OWXTGqXXx6vfiTz/4m77GjFxbZQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=tU/jN2Y5Yuit4duascOWiZC9fm7dwhzfg8B4sN33WrBH3hmn9UKw1z4HOLVV7VMFb
	 egKWKjUdhW6q0uIhdN6/JmxTl9UJoxoAzpZCS9VZyMt+mpG3Mg2fbiMdyUAi2IJxs5
	 DV8R9/WboQvkhc7We5Dr04h5X+ay3vma0PhrOMsdauZKA2ABfS8Lt1WCZAuMK0hbRV
	 Y2TxVSJZLHgIo60sdQn3JDtW61LFJez5UR71VcYwKjVGqDao6u7+bw5xTmC5yMQu/v
	 lIPSS6rJxuYII44gXdA4+zb+YN461aq1iPyh7WiCLKHvK+ETpM+01XEhgR79dAKrvG
	 9YzZbNzo9FypQ==
Date: Sat, 5 Aug 2023 09:19:40 +0200
From: Simon Horman <horms@kernel.org>
To: Nick Child <nnac123@linux.ibm.com>
Cc: netdev@vger.kernel.org, haren@linux.ibm.com, ricklind@us.ibm.com,
	danymadden@us.ibm.com, tlfalcon@linux.ibm.com,
	bjking1@linux.ibm.com
Subject: Re: [PATCH net 2/5] ibmvnic: Unmap DMA login rsp buffer on send
 login fail
Message-ID: <ZM34DHovcA8kfhIo@vergenet.net>
References: <20230803202010.37149-1-nnac123@linux.ibm.com>
 <20230803202010.37149-2-nnac123@linux.ibm.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230803202010.37149-2-nnac123@linux.ibm.com>

On Thu, Aug 03, 2023 at 03:20:07PM -0500, Nick Child wrote:
> If the LOGIN CRQ fails to send then we must DMA unmap the response
> buffer. Previously, if the CRQ failed then the memory was freed without
> DMA unmapping.
> 
> Fixes: c98d9cc4170d ("ibmvnic: send_login should check for crq errors")
> Signed-off-by: Nick Child <nnac123@linux.ibm.com>

Reviewed-by: Simon Horman <horms@kernel.org>


