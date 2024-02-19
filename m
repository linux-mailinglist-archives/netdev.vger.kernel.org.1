Return-Path: <netdev+bounces-73110-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 231CA85AF3A
	for <lists+netdev@lfdr.de>; Mon, 19 Feb 2024 23:52:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6F700B22675
	for <lists+netdev@lfdr.de>; Mon, 19 Feb 2024 22:52:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EBE054BC4;
	Mon, 19 Feb 2024 22:52:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KyaQHVrh"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A8D45381A
	for <netdev@vger.kernel.org>; Mon, 19 Feb 2024 22:52:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708383126; cv=none; b=R943VQh55Nfb7b4xwVj0bZgCfIIQ3K+gYpySE6OTuKk805FM5Fiju1hI4w++k6Rjmji4od2ZjeZgSATkx4J+zPlrjDCDvEepFF6QNQcq2WYTvTTSy3dZcnsl8ovFxMvxrU9q5hqLTPOcKGeTup1XOgFHvtf3JFyvvKjVXyjHFmI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708383126; c=relaxed/simple;
	bh=xez+QJviQWK9L3xnO1vL4Jp2d0cjYlSr0Rk8VmKz5KA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CZADbD5Y8ZllMkNLNdTSk6Jdsslr0rKbBTX2ziMPtO222DHjj/4XHMQmO9kiVaJnfC3lL+ZVShljATBJvv66xYVannArNRI/BQ3n6N38e/jFtoeiBDGm5xao4irrZDZJk+qrwYvz4OZs9FTibfdg5DKknNvpK/BRxBDr/97tW3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KyaQHVrh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17888C433F1;
	Mon, 19 Feb 2024 22:52:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708383125;
	bh=xez+QJviQWK9L3xnO1vL4Jp2d0cjYlSr0Rk8VmKz5KA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=KyaQHVrhuApV6uW37CAZhBlMPrQ6x2/WxFaPILjDo73+OOx2F9wez8XqyAXUc8LWP
	 EKwckTv/CsD+IDKl/+63AK3fzW2XLAvM5cAjiRtO1dqkh/TZK+hhCxrrXTjodxdQ4n
	 8YWjw1GNqz7MMf4LgknAhsiXiMbDjkP1iiu6BkasfjctBGO89/prpAAbiZ5999fKM9
	 HvcQsV1bY7GoEYIifXuK36a2604u1wxpMin5wiAznzb+6j1V7WjvgC68/kt0CsqKex
	 TQWnTIrRzrWY3mtMGRtSZ1thIOgkUzCys87wOKD/i/O/R0bIvgoVcH2ezW3H4n0k9m
	 HlEsYoELSqWCw==
Date: Mon, 19 Feb 2024 14:52:04 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Jiri Pirko <jiri@resnulli.us>
Cc: netdev@vger.kernel.org, pabeni@redhat.com, davem@davemloft.net,
 edumazet@google.com, jacob.e.keller@intel.com,
 swarupkotikalapudi@gmail.com, donald.hunter@gmail.com, sdf@google.com,
 lorenzo@kernel.org, alessandromarcolini99@gmail.com
Subject: Re: [patch net-next 06/13] tools: ynl: introduce attribute-replace
 for sub-message
Message-ID: <20240219145204.48298295@kernel.org>
In-Reply-To: <20240219172525.71406-7-jiri@resnulli.us>
References: <20240219172525.71406-1-jiri@resnulli.us>
	<20240219172525.71406-7-jiri@resnulli.us>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 19 Feb 2024 18:25:22 +0100 Jiri Pirko wrote:
> For devlink param, param-value-data attr is used by kernel to fill
> different attribute type according to param-type attribute value.
> 
> Currently the sub-message feature allows spec to embed custom message
> selected by another attribute. The sub-message is then nested inside the
> attr of sub-message type.
> 
> Benefit from the sub-message feature and extend it. Introduce
> attribute-replace spec flag by which the spec indicates that ynl should
> consider sub-message as not nested in the original attribute, but rather
> to consider the original attribute as the sub-message right away.

The "type agnostic" / generic style of devlink params and fmsg
are contrary to YNL's direction and goals. YNL abstracts parsing
and typing using external spec. devlink params and fmsg go in a
different direction where all information is carried by netlink values
and netlink typing is just to create "JSON-like" formatting.
These are incompatible ideas, and combining these two abstractions
in one library provides little value - devlink CLI already has an
implementation for fmsg and params. YNL doesn't have to cover
everything.

