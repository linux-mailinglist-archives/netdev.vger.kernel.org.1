Return-Path: <netdev+bounces-111560-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D7F7C93193B
	for <lists+netdev@lfdr.de>; Mon, 15 Jul 2024 19:27:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 92E26280F97
	for <lists+netdev@lfdr.de>; Mon, 15 Jul 2024 17:27:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8925D2421D;
	Mon, 15 Jul 2024 17:27:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uyhKgGzl"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63D264D8A3
	for <netdev@vger.kernel.org>; Mon, 15 Jul 2024 17:27:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721064447; cv=none; b=UMN5sDKo8MRsaU+zS48C9nPbSKAI17p81jj4p+BIAcGLdAlLQiVoOKWYTIE2Bx+ClKahSsXCRQG+NTRh83KfNvlCUqC89kscwKVZuFItDCOdfCWrwoY7GDay5/nqJNYZlIe6TaSYtludtjosOJW507v8fZITqOziMl4Rc4yuxRI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721064447; c=relaxed/simple;
	bh=QdrkNgd6gCuS6mvkXahho1xuQ76NsCCfIYNyxSW7bFo=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=Un4taqTWdYnzaWTI8mFnn7A1SJSQoRxB7EkF9kH2tz/RMr626IxFoCnbFbgrKZlvWhQknx9I14HPbSV1v4ZXvxkY32u4qywdLx0AFR9Cchs5joOHXlTC81mY4WthcRa2+5/fqAguMxxLzmG4HDgYeCy8FjSUR1HApqGcv9hKby8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uyhKgGzl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 973F6C4AF0D;
	Mon, 15 Jul 2024 17:27:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721064446;
	bh=QdrkNgd6gCuS6mvkXahho1xuQ76NsCCfIYNyxSW7bFo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=uyhKgGzl+tUIM84rYGV2cL2vuWZ4ds0+DqmmrmIiCJRs0Ivu+ohYRXMvVBBfQEeCx
	 PAbOZfP9GfO5m9T1QaBxSoRtgUkK+qfAnbG9CsBSCdQF/m04aDRx+6jxh76xDDOnIj
	 3Wdqgl/LNToVLZbz/1kPWX2qF5fKbBNhsNtq1Kthc2WKmMgVIX3vfsup1YusNtSf27
	 Wc9WjDq6NatZ1+r3fbQaS/o5DW2EUh1bhqZ5MEegRrkIgbwCJK/UJZPGj78JFZbW+6
	 9vD3eStnRqLJE8vqLXheAKa8kL14E7xeXhAO7o6Et7yHwR8lorjGCEfQ+1hLksEPto
	 WglsxPgooUUMw==
Date: Mon, 15 Jul 2024 12:27:24 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Michael Chan <michael.chan@broadcom.com>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, pavan.chebbi@broadcom.com,
	andrew.gospodarek@broadcom.com,
	Somnath Kotur <somnath.kotur@broadcom.com>,
	Hongguang Gao <hongguang.gao@broadcom.com>
Subject: Re: [PATCH net-next 6/9] bnxt_en: Remove register mapping to support
 INTX
Message-ID: <20240715172724.GA435391@bhelgaas>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240713234339.70293-7-michael.chan@broadcom.com>

On Sat, Jul 13, 2024 at 04:43:36PM -0700, Michael Chan wrote:
> In legacy INTX mode, a register is mapped so that the INTX handler can
> read it to determine if the NIC is the source of the interrupt.  This
> and all the related macros are no longer needed.

This commit log only makes sense if you already know INTx support has
been removed.  Ideally a commit log would make sense by itself,
without having to extract all the preceding history.

