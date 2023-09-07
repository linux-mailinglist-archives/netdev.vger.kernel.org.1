Return-Path: <netdev+bounces-32395-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BECF07973B9
	for <lists+netdev@lfdr.de>; Thu,  7 Sep 2023 17:31:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 78922281643
	for <lists+netdev@lfdr.de>; Thu,  7 Sep 2023 15:31:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B50C9125DD;
	Thu,  7 Sep 2023 15:31:33 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1808329AB
	for <netdev@vger.kernel.org>; Thu,  7 Sep 2023 15:31:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D352C4339A;
	Thu,  7 Sep 2023 15:31:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1694100691;
	bh=76rEwfE/uTJS8ezcSl7+Wi3KuWBqHArCGxvgwyT7MEk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bRJ2pEom4OLSlDgiZnthU1HnTzpGSYXMHsgk2WtPSuO1ZGspi0pf2HMsPMv6BpmTo
	 +3cutUabz0foPK3TwOkE0fplhrEY9seCaRtJejmBEdDJ9+vX3wCmGYdINRQs6OWNeW
	 CNiNezaeXHXsKjr/wz6+Ybcw2+wKqfG/gj2fTess9yB8XeXN8HHL+u0HrG9T+5kksx
	 G+LvWEQBPBb+nobha+ZqDSLnmqHy3U/3ZB0gi3vhq5RtCWgcgdkMDAqyMUouuzGEaV
	 CTY7D1f0cIRQBl+mNDuSudE+IRvYo5N8tGIGie9uGuH73bB+vmlYKO4uv/GeS2g7SL
	 w0eaw79B2mY6Q==
Date: Thu, 7 Sep 2023 17:31:26 +0200
From: Simon Horman <horms@kernel.org>
To: Petr Oros <poros@redhat.com>
Cc: netdev@vger.kernel.org, jesse.brandeburg@intel.com,
	anthony.l.nguyen@intel.com, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	intel-wired-lan@lists.osuosl.org, linux-kernel@vger.kernel.org,
	mschmidt@redhat.com, ivecera@redhat.com, ahmed.zaki@intel.com
Subject: Re: [PATCH net v2 1/2] iavf: add iavf_schedule_aq_request() helper
Message-ID: <20230907153126.GI434333@kernel.org>
References: <20230907150251.224931-1-poros@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230907150251.224931-1-poros@redhat.com>

On Thu, Sep 07, 2023 at 05:02:50PM +0200, Petr Oros wrote:
> Add helper for set iavf aq request AVF_FLAG_AQ_* and immediately
> schedule watchdog_task. Helper will be used in cases where it is
> necessary to run aq requests asap
> 
> Signed-off-by: Petr Oros <poros@redhat.com>
> Co-developed-by: Michal Schmidt <mschmidt@redhat.com>
> Signed-off-by: Michal Schmidt <mschmidt@redhat.com>
> Co-developed-by: Ivan Vecera <ivecera@redhat.com>
> Signed-off-by: Ivan Vecera <ivecera@redhat.com>

Reviewed-by: Simon Horman <horms@kernel.org>


