Return-Path: <netdev+bounces-14610-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 57579742A67
	for <lists+netdev@lfdr.de>; Thu, 29 Jun 2023 18:15:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 885AB1C20AD1
	for <lists+netdev@lfdr.de>; Thu, 29 Jun 2023 16:15:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A47F212B9E;
	Thu, 29 Jun 2023 16:15:02 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECA60134AF
	for <netdev@vger.kernel.org>; Thu, 29 Jun 2023 16:15:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17EA1C433C0;
	Thu, 29 Jun 2023 16:15:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1688055300;
	bh=ZZ0x/hfKHeOr7h69Wp129mhxshiks3zVTS8Y7lb2+Dk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=PFhVcRaysQqUKb92I6zVf3GTwCJFBnGsYiGsW7XDdQLB1Pmk28lq78fhcQmj/mHAx
	 7wJ+Oi3uiV6f0WQ0ZgyPlB9lup3N8ZsMRWbvPfG6pX8FRiBSa3HcdxujBYAzVX9LHV
	 ATdClk7KBcfPVW6IUCJgbL2iHQDD5uq8g1fHBXNwl5+LUosSHeMD3GkNQrYys6wE1J
	 tpi7rGqRKY2VH/zGf5uI2UJ3QhzOetvBUo8GQgy3kxha+tdPg1JLxuMNPCfr0EOtDk
	 ny8dxnVDuhujbG+/LlFCdNaNrKJ/bEKWC4wpZ37Yx9/qufkr7E9XsdoaYUonVDNIML
	 kmDNBbN9PZJ+g==
Date: Thu, 29 Jun 2023 09:14:59 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Tobias Heider <me@tobhe.de>
Cc: Paolo Abeni <pabeni@redhat.com>, Michael Chan
 <michael.chan@broadcom.com>, Siva Reddy Kallam <siva.kallam@broadcom.com>,
 Prashant Sreedharan <prashant@broadcom.com>, Michael Chan
 <mchan@broadcom.com>, netdev@vger.kernel.org, "David S. Miller"
 <davem@davemloft.net>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Add MODULE_FIRMWARE() for FIRMWARE_TG357766.
Message-ID: <20230629091459.5e442d21@kernel.org>
In-Reply-To: <ZJ2JARrRUUd4YRvX@tobhe.de>
References: <ZJt7LKzjdz8+dClx@tobhe.de>
	<CACKFLinEbG_VVcMTPVuHeoQ6OLtPRaG7q2U5rvqPqdvk7T2HwA@mail.gmail.com>
	<aa84a2f559a246b82779198d3ca60205691baa94.camel@redhat.com>
	<ZJ2JARrRUUd4YRvX@tobhe.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 29 Jun 2023 15:37:05 +0200 Tobias Heider wrote:
> Would "Fixes: c4dab50697ff ("video: remove unnecessary platform_set_drvdata()")"
> work?

Modulo the text in the brackets but yes ;) I'll add when applying.

