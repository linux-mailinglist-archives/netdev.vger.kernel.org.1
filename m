Return-Path: <netdev+bounces-101036-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 294768FD0C7
	for <lists+netdev@lfdr.de>; Wed,  5 Jun 2024 16:24:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B6211B289EF
	for <lists+netdev@lfdr.de>; Wed,  5 Jun 2024 13:54:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFAC325774;
	Wed,  5 Jun 2024 13:49:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J5CKeyuf"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9777ABA27;
	Wed,  5 Jun 2024 13:49:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717595359; cv=none; b=OFQOUiPenOIMb57/g3HOIcOP3N+dnz3HoXT043sLvlGxIUfQdSQGVOX83+ZB3RnY6v6CbalG+EHENR2KgNEFYhgFHTK7daLzoK1Zb3yrkmpBwgrt9mfAqMf8KOqvvAFVU+Re0m1bjXLwaHwN/dxrOueEPsHqeqlIPVKPY8RFAQc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717595359; c=relaxed/simple;
	bh=HxJyKDcwxKVpZkWRLhPVC9seiRNb7oUVJSRcKq1ZMvk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Nui6+LuRZMNP6C5odVxR7wBOGoRFiMcov2M6Godd8FGKatMJoSXJI5DEMasiwjXVENxlbuZciH+mqZFY4+myr46DC3z9IrngR6WH7wVfwo5Z97Z3O1QdIpQI0VDDIeY7N0v8DdmIIhivlBh1wubBEsX2devss6RU+UnlFcgGzMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J5CKeyuf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A7CCC2BD11;
	Wed,  5 Jun 2024 13:49:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717595359;
	bh=HxJyKDcwxKVpZkWRLhPVC9seiRNb7oUVJSRcKq1ZMvk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=J5CKeyuftLREi/fwCykuRbnMB2KwEGVOfLjLs1Sr2+ONi1u3tXcqPbV0pivM4ihbh
	 ibgIo8P7fFqw5nXi6xRqFrfpxyA+SLjl/J1dSR0xlrsYc7jV7rAB10lWmNtz1xcnQI
	 LqTSe8ptm4DR68SuYO9o6J/nSh4ahxeUiD4kjtFMROs404WJlvQg8HBfPUSBLVk3f+
	 C+xyGyRkfx8UOUKifUeSH/kMZvsucpFlYIUSXXke6PvrJyp/9at9fiF2hQ+FeeMqIm
	 o8lyD0vqF91KzmoxCou4wavGn+MJsv52p7w0epFNC/FUocEwkK/1GxROOHUQMdh0vs
	 mDVMXK0JIeGJw==
Date: Wed, 5 Jun 2024 14:49:14 +0100
From: Simon Horman <horms@kernel.org>
To: Ronak Doshi <ronak.doshi@broadcom.com>
Cc: netdev@vger.kernel.org,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 net-next 1/4] vmxnet3: prepare for version 9 changes
Message-ID: <20240605134914.GL791188@kernel.org>
References: <20240531193050.4132-1-ronak.doshi@broadcom.com>
 <20240531193050.4132-2-ronak.doshi@broadcom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240531193050.4132-2-ronak.doshi@broadcom.com>

On Fri, May 31, 2024 at 12:30:46PM -0700, Ronak Doshi wrote:
> vmxnet3 is currently at version 7 and this patch initiates the
> preparation to accommodate changes for up to version 9. Introduced
> utility macros for vmxnet3 version 9 comparison and update Copyright
> information.
> 
> Signed-off-by: Ronak Doshi <ronak.doshi@broadcom.com>
> Acked-by: Guolin Yang <guolin.yang@broadcom.com>

Reviewed-by: Simon Horman <horms@kernel.org>


