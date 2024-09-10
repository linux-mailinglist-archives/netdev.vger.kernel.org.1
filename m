Return-Path: <netdev+bounces-126879-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 16C44972C35
	for <lists+netdev@lfdr.de>; Tue, 10 Sep 2024 10:34:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C2F6C1F21399
	for <lists+netdev@lfdr.de>; Tue, 10 Sep 2024 08:34:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD72C17BB24;
	Tue, 10 Sep 2024 08:34:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S2zfYb3b"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA38B175D22
	for <netdev@vger.kernel.org>; Tue, 10 Sep 2024 08:34:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725957267; cv=none; b=HAhsQn4+go8M6pcjCUQbLrf0zk0ugDps3ix2WDmUQ5RavVkW6sK9JtzMzAHr08WsjOwkb8buuahsukJ6h9q5o/mX0lQqCIZuFucq7Z8hXRnO3O6l+TJFjmZuGzD4PFcMxx2HoKTt0ipRlbWmmbzkkllVeDdwaYksEtot+Npl43s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725957267; c=relaxed/simple;
	bh=Bt2CLk3f+YtNLVhasHP9LcHfqjSkcUJIMOXPa92BEEU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pSQQkKPSryZ43JIbGbKApCvBLmClR1od44XCo3WvEpriW+gYi1N6IxqRweETBqQ5vhfDUBCbKbWjM+fXFhZCG1oKK/oajwj52LIsBWEyyicl8Z1uaVn2cGBopOByWFlHH+qyli2SjcdkX+luX2z24tkJZbBwnJSMiuHyOATwA8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S2zfYb3b; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 736BEC4CEC3;
	Tue, 10 Sep 2024 08:34:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725957267;
	bh=Bt2CLk3f+YtNLVhasHP9LcHfqjSkcUJIMOXPa92BEEU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=S2zfYb3boYRmtt/+N+oL0BbYnNqkEiZS+p0xsmuMJmtO/R/XA1RYNwP/TrTi65IPs
	 xiPEOs1p0OVgAlDHA2sMs47GHFQGRxOWis2/iPR93McDosVBpZnkrxbftkyOP1cF/Q
	 IMnZerUcPvOuqgrE2omUB5oAw20aSTTni03MWSrw7JXuSjEPE9AkP1q0hv5ZLGqw9g
	 4d/RV/qU5UWOIuRlzFqk+Y88rwWlrUNddK3E7727yHXVcVMIBhj5LI98zuJRUZoXyP
	 CX6Me00rWISIYZaFuvRLJl8+SkfMFrl40ba4BPMmPxeXKt9p+vzDusPWp5eEiiSdFU
	 /qiRbfDjnh1kQ==
Date: Tue, 10 Sep 2024 09:34:23 +0100
From: Simon Horman <horms@kernel.org>
To: Michael Chan <michael.chan@broadcom.com>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, gospo@broadcom.com,
	selvin.xavier@broadcom.com, pavan.chebbi@broadcom.com
Subject: Re: [PATCH net-next 3/3] bnxt_en: resize bnxt_irq name field to fit
 format string
Message-ID: <20240910083423.GF525413@kernel.org>
References: <20240909202737.93852-1-michael.chan@broadcom.com>
 <20240909202737.93852-4-michael.chan@broadcom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240909202737.93852-4-michael.chan@broadcom.com>

On Mon, Sep 09, 2024 at 01:27:37PM -0700, Michael Chan wrote:
> From: Edwin Peer <edwin.peer@broadcom.com>
> 
> The name field of struct bnxt_irq is written using snprintf in
> bnxt_setup_msix(). Make the field large enough to fit the maximal
> formatted string to prevent truncation.  Truncated IRQ names are
> less meaningful to the user.  For example, "enp4s0f0np0-TxRx-0"
> gets truncated to "enp4s0f0np0-TxRx-" with the existing code.
> 
> Make sure we have space for the extra characters added to the IRQ
> names:
> 
>   - the characters introduced by the static format string: hyphens
>   - the maximal static substituted ring type string: "TxRx"
>   - the maximum length of an integer formatted as a string, even
>     though reasonable ring numbers would never be as long as this.
> 
> Signed-off-by: Edwin Peer <edwin.peer@broadcom.com>
> Signed-off-by: Michael Chan <michael.chan@broadcom.com>

Reviewed-by: Simon Horman <horms@kernel.org>


