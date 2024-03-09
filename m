Return-Path: <netdev+bounces-78901-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 98077876F08
	for <lists+netdev@lfdr.de>; Sat,  9 Mar 2024 04:58:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A353C282122
	for <lists+netdev@lfdr.de>; Sat,  9 Mar 2024 03:57:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F48833070;
	Sat,  9 Mar 2024 03:57:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Dwi8/3re"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFD7A12E5B
	for <netdev@vger.kernel.org>; Sat,  9 Mar 2024 03:57:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709956676; cv=none; b=skSZJ3ekslTPKIzQYevp+Qkj2xajR0wNg+LSg15hhpEO2OpTCdhF1Rd0srP6J5JtaZQXD5XuUKInQkzEy6JFXgfpthz8o8zCtqy7hmlfdAQWmBMUbzY5RxJWturgMK8EzQjctZ5o3Zn+afWTxJDOgnZJZdkY/p6bIQZcMr9eteQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709956676; c=relaxed/simple;
	bh=rNIVBXAHfdzPCNXtNJAZ2lK1ggAdCjYtecmFVTFFRug=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BcUCoQio1CdXlXRyeiMOhF4rYJG/QAIQQOPoFBRQIXb+1wR5vBrO+04vRG2jIcIgaFkx4BB5Wl/vIGOQTZEeoWJRg7CfMZHSxABapUQllDrCzRhwfhOZ6vMjlH8MvxVAS8OT8HEEAguCqjG+CS7MdYIL7LIi3uWeFW/AC31kF5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Dwi8/3re; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40665C433C7;
	Sat,  9 Mar 2024 03:57:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709956675;
	bh=rNIVBXAHfdzPCNXtNJAZ2lK1ggAdCjYtecmFVTFFRug=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Dwi8/3reqNZV6gPSTKepjyRkNnQd3Xi0Yl9rIpmpt9hyAGVhAtKOuS/M1HMqg+ZIq
	 GswpUMHnBuC4z57RSAEFZmJLy8YwzbXMFvOjAhHllOc38IbBBLXMsQzXsqs8Jl8htI
	 M57dvoGj22DDxWBiMxbhJxEZ9DteVieetSnOkn+qPjPmRViGjQKgMYve6DepjxquI8
	 PjFDSaAQj5iCPL+sAgOw6rbFrb1tYOH/V5NxNnbp6rEM0yJI6jEQb35zPJfqZbB5JW
	 7jTIqjX3GpXwfRngT9UFoEO0eQHMWCIr+6cOGPP5lfFxSbZVckV5YqBSWYIrciusLy
	 x9LOWIQhAPEzw==
Date: Fri, 8 Mar 2024 19:57:54 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Hangbin Liu <liuhangbin@gmail.com>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCHv2 net-next] netlink: specs: support unterminated-ok
Message-ID: <20240308195754.4eb5f47a@kernel.org>
In-Reply-To: <20240308081239.3281710-1-liuhangbin@gmail.com>
References: <20240308081239.3281710-1-liuhangbin@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri,  8 Mar 2024 16:12:39 +0800 Hangbin Liu wrote:
> ynl-gen-c.py supports check unterminated-ok, but the yaml schemas don't
> have this key. Add this to the yaml files.
> 
> Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>

Reviewed-by: Jakub Kicinski <kuba@kernel.org>

