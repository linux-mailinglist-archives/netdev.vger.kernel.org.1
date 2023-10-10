Return-Path: <netdev+bounces-39406-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ADFE47BF0E7
	for <lists+netdev@lfdr.de>; Tue, 10 Oct 2023 04:32:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 65A1C2817E0
	for <lists+netdev@lfdr.de>; Tue, 10 Oct 2023 02:32:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3958437E;
	Tue, 10 Oct 2023 02:32:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WKhfXdPX"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A7DC4419
	for <netdev@vger.kernel.org>; Tue, 10 Oct 2023 02:32:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EFE85C433C8;
	Tue, 10 Oct 2023 02:31:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1696905120;
	bh=6o/kjifs3KbWaTn2Ziz1oUxyttEWW/VK6fOR+vDlP+M=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=WKhfXdPXd4hKZolc8afo6KCkwSDD6WhLH7rwXXpXObKidjQyYtNHlXwKqlcbFht/l
	 wSvUEl5v49s7syQjj7ob+F+oZtM6fZywh61M8OXBU99PJvWytwTMkEVDlEyUcvCWKT
	 9cuFpsjbxbhENrXR4KrSumFHPs9OWoShBAMqSDjTqVMTfh9OuERP1e/8U/s7bKcxCy
	 FOMAoC/WnBYBgYwmHAHnIZnztnl5w8KJW5DR/UN2U1diXMclcw1kSxGFdSLljTBBUk
	 NGFp/71CmtFTHdOFu3vWO0CqLXZWKjQ1H8+eSfywLLCLpmy4B9cHa65BtqlK2FszRM
	 vzMaETWwxpwOA==
Date: Mon, 9 Oct 2023 19:31:58 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Breno Leitao <leitao@debian.org>
Cc: jlbec@evilplan.org, davem@davemloft.net, pabeni@redhat.com, Eric Dumazet
 <edumazet@google.com>, hch@lst.de, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, horms@kernel.org
Subject: Re: [PATCH net-next v2 1/3] netconsole: Initialize configfs_item
 for default targets
Message-ID: <20231009193158.28a12cd8@kernel.org>
In-Reply-To: <20231005123637.2685334-2-leitao@debian.org>
References: <20231005123637.2685334-1-leitao@debian.org>
	<20231005123637.2685334-2-leitao@debian.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu,  5 Oct 2023 05:36:34 -0700 Breno Leitao wrote:
> +static void populate_configfs_item(struct netconsole_target *nt,
> +				   int cmdline_count);

Could you move alloc / free_param_target() to avoid the forward
declaration? (separate patch)

