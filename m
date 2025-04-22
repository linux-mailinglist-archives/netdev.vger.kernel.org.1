Return-Path: <netdev+bounces-184631-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 847BCA968F7
	for <lists+netdev@lfdr.de>; Tue, 22 Apr 2025 14:20:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 597253A9F6E
	for <lists+netdev@lfdr.de>; Tue, 22 Apr 2025 12:20:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61060202960;
	Tue, 22 Apr 2025 12:20:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OoSBlq0q"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DA9827C863
	for <netdev@vger.kernel.org>; Tue, 22 Apr 2025 12:20:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745324424; cv=none; b=RzJw77TTfSsh6KNO4UUOsL299l94BHJuA76UQENNivQZ/5nk7oxGG/gsn3/OuOzfJgRw8qojfrN05jcxhsePBxJkX06otBeRuMaOpnXTLybqd2KKzfE3pUjvuIWV4sViFxY4Q665LNWBdFrTbguUHQ9gEX8GYvpE03DOv1c//0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745324424; c=relaxed/simple;
	bh=ZrshQB/HvJt55tWOH/LLIHeQSXBuQob4lAuwecjZ5uo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pY+fvLyvtViaQdWbr/CpFburnpRXYESiWeAvxeelA0YeMzlSgqzs4iQo8XeQemdvbLpyZUuklJzMdeITKc/XKe0JZHEIiBh5j17GenAPTq0zMIP+jcGJZn/FqRj/yjck3gviyJtM0OckpYc2j3kTd67vNkkJoOvFGWH2tH3f7Kc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OoSBlq0q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2D8DC4CEE9;
	Tue, 22 Apr 2025 12:20:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745324423;
	bh=ZrshQB/HvJt55tWOH/LLIHeQSXBuQob4lAuwecjZ5uo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=OoSBlq0qcd+pjnS61iStg4j+F5ysUfDmpOXLZ/2kRJqUHkvs1d7EF3xB9jjRw5qzG
	 EBddFnac+/2ZYP9hSb7L97+n81/ZNPuZIWVNOd9bIHsCcX80LeaL1jYKhJxHKgFHq2
	 KC+NPDlgI6LnOfm2kohlxx7FgKioD5qdfP6fCr2HkXLDF6CXTQDk02pfOg3uBnhXNo
	 HmmfWyTPdaY3HhOc+msO06Br5EK4Px0WqCcGySt+vH99Kf59BUhgkPpBQxytS9qyhX
	 oMsMAZCwZc7hQ5fzBI8aTGzJnlMW2X9DsIr7j451JCAJTg4zLZJaIwT7p6tm/9THo6
	 5KUtS7siGCwzQ==
Date: Tue, 22 Apr 2025 13:20:20 +0100
From: Simon Horman <horms@kernel.org>
To: Dave Marquardt <davemarq@linux.ibm.com>
Cc: netdev@vger.kernel.org, michal.swiatkowski@linux.intel.com,
	linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH net-next v3 1/3] net: ibmveth: Indented struct
 ibmveth_adapter correctly
Message-ID: <20250422122020.GB2843373@horms.kernel.org>
References: <20250416205751.66365-1-davemarq@linux.ibm.com>
 <20250416205751.66365-2-davemarq@linux.ibm.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250416205751.66365-2-davemarq@linux.ibm.com>

On Wed, Apr 16, 2025 at 03:57:49PM -0500, Dave Marquardt wrote:
> Made struct ibmveth_adapter follow indentation rules
> 
> Signed-off-by: Dave Marquardt <davemarq@linux.ibm.com>

Reviewed-by: Simon Horman <horms@kernel.org>


