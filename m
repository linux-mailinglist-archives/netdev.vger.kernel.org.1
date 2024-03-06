Return-Path: <netdev+bounces-78058-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A244873E1B
	for <lists+netdev@lfdr.de>; Wed,  6 Mar 2024 19:07:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CC4B51C22965
	for <lists+netdev@lfdr.de>; Wed,  6 Mar 2024 18:07:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A4C913BAF6;
	Wed,  6 Mar 2024 18:07:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jW1b95YN"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 570CE135A4C
	for <netdev@vger.kernel.org>; Wed,  6 Mar 2024 18:07:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709748452; cv=none; b=bKHlmQxjVd7K51J7BWUUDegxsED12tG2I21MJaWoNFRkoUYvMbIBlCBhny7X7+wGus1aZZj1qr8P/fD6EZiMC7zZ82Pb+yOFqqOBTBMERwE81n4UbYRuXC60mDrPW5RxOPUmukf4E/0CXvfzBUSwkkz+SfJUp3AvSK0cMGE1co8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709748452; c=relaxed/simple;
	bh=/D5VlutEPZKJGe44lfMrKs8ux3rOMHb9oK6pI4SWpP0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=V8WbEJRW8uQ6RlJyToHLb1fsWnobppe59ar9IIYK3B1NX+48Rme8zQlcE2UIIcMGHL70nRJf+JZCakHxX+yXEy3K/C3U6r/XZlikgJaqb/uWjfWMhTejDZCSruWvS/E6D8f4vyIwFzOQ0wioxcdQaLIrKMBvZlO6I75wrSk+OCA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jW1b95YN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 787C0C43390;
	Wed,  6 Mar 2024 18:07:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709748450;
	bh=/D5VlutEPZKJGe44lfMrKs8ux3rOMHb9oK6pI4SWpP0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=jW1b95YNqV222UK1bZdq4LFSWx0QzNb+JvY5gR6WupXghxkQh2i3QiiG+XfCVEJz3
	 +FxZ3FA/I7VdajfEm8y7nGLIO7/yvuROaFqVzatO6wA7KRINQ7L4aK63G31G9C4bxl
	 GnnxVi6oxdWQw7cL998Kw3gAwZx7eBzvghM3nD5tjkCBkmXlOnL0NcEFJWtV4nTzRU
	 8mplFsxQNOM6lxUIlKYXEpEk/nh7T0UgadpCO8L4Ap2zayeLFJi/+FuIkmRwGLCBPx
	 Gsj0lqpKtivTO4GBQWuXVYCrCcwG2cGAX113eTTnyTmY9hxaSL9YUvaPGeZCLh4CFX
	 3nr8tPTu02ylA==
Date: Wed, 6 Mar 2024 10:07:29 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Donald Hunter <donald.hunter@gmail.com>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Jacob
 Keller <jacob.e.keller@intel.com>, Jiri Pirko <jiri@resnulli.us>, Stanislav
 Fomichev <sdf@google.com>, donald.hunter@redhat.com
Subject: Re: [PATCH net-next v2 4/5] tools/net/ynl: Add nest-type-value
 decoding
Message-ID: <20240306100729.6cab77a3@kernel.org>
In-Reply-To: <20240306125704.63934-5-donald.hunter@gmail.com>
References: <20240306125704.63934-1-donald.hunter@gmail.com>
	<20240306125704.63934-5-donald.hunter@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed,  6 Mar 2024 12:57:03 +0000 Donald Hunter wrote:
> The nlctrl genetlink-legacy family uses nest-type-value encoding as
> described in Documentation/userspace-api/netlink/genetlink-legacy.rst
> 
> Add nest-type-value decoding to ynl.

Reviewed-by: Jakub Kicinski <kuba@kernel.org>

