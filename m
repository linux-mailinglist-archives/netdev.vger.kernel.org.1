Return-Path: <netdev+bounces-55567-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 031EF80B5FA
	for <lists+netdev@lfdr.de>; Sat,  9 Dec 2023 20:11:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B2B9D280FF1
	for <lists+netdev@lfdr.de>; Sat,  9 Dec 2023 19:11:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91D7019BCF;
	Sat,  9 Dec 2023 19:11:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JwYAfxWz"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 774B01944E
	for <netdev@vger.kernel.org>; Sat,  9 Dec 2023 19:11:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6D8FC433C7;
	Sat,  9 Dec 2023 19:11:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702149110;
	bh=GoCf7IwFe+k6fUAIEuS1Bv4Gt8vQiC8SZUGXlwqNP14=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JwYAfxWz/Df9+K8+uODNixBenK018c+cULFPVo3AGdn8/km789jmrQDYpXgRqzkEo
	 dXIFMhQa6QVAEnDv8dCpcQJgZZEBfeAfk77SYbQdg/AkCKzowdJBQIL3NuWZRs6X5M
	 Cf4xbmuqCaU6twGy+HbUEx73seYsDhuu9VZOV+aiqaAR1EuGQQSGyZYswNvmSHS1Ow
	 ZImqyTovXdZri7TCWvpyaucHDdbnycZoovR2gwOvIadbKgxv94ztXZjqO3/m3Zm8LN
	 3kawYMtQBOH6DnmKOrXaRxebNg7Lb94raNdALbGEFvClLQ6vJ1p1YuXTDI7DcMraft
	 wSHe2nEQI8mTQ==
Date: Sat, 9 Dec 2023 19:11:45 +0000
From: Simon Horman <horms@kernel.org>
To: Kunwu Chan <chentao@kylinos.cn>
Cc: jesse.brandeburg@intel.com, anthony.l.nguyen@intel.com,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, jeffrey.t.kirsher@intel.com,
	shannon.nelson@amd.com, intel-wired-lan@lists.osuosl.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	Kunwu Chan <kunwu.chan@hotmail.com>
Subject: Re: [PATCH v5 iwl-next] i40e: Use correct buffer size in
 i40e_dbg_command_read
Message-ID: <20231209191145.GD5817@kernel.org>
References: <20231208031950.47410-1-chentao@kylinos.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231208031950.47410-1-chentao@kylinos.cn>

On Fri, Dec 08, 2023 at 11:19:50AM +0800, Kunwu Chan wrote:
> The size of "i40e_dbg_command_buf" is 256, the size of "name"
> depends on "IFNAMSIZ", plus a null character and format size,
> the total size is more than 256.
> 
> Improve readability and maintainability by replacing a hardcoded string
> allocation and formatting by the use of the kasprintf() helper.
> 
> Fixes: 02e9c290814c ("i40e: debugfs interface")
> Suggested-by: Simon Horman <horms@kernel.org>
> Suggested-by: Alexander Lobakin <aleksander.lobakin@intel.com>
> Suggested-by: Tony Nguyen <anthony.l.nguyen@intel.com>
> Cc: Kunwu Chan <kunwu.chan@hotmail.com>
> Signed-off-by: Kunwu Chan <chentao@kylinos.cn>

Reviewed-by: Simon Horman <horms@kernel.org>


