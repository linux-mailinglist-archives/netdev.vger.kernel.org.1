Return-Path: <netdev+bounces-24200-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A6A976F38B
	for <lists+netdev@lfdr.de>; Thu,  3 Aug 2023 21:39:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 48C2E1C21606
	for <lists+netdev@lfdr.de>; Thu,  3 Aug 2023 19:39:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B761F25912;
	Thu,  3 Aug 2023 19:39:21 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A17E25178
	for <netdev@vger.kernel.org>; Thu,  3 Aug 2023 19:39:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C0ADC433C7;
	Thu,  3 Aug 2023 19:39:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1691091560;
	bh=HOcib4kefhVSk99mcS9v25+78Or2wY9qn5QUkaKoQOI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ez9OLRog2Y3k2WlQlWctQguzOpdOMMkLi2YetxWUhHdaVYm/62L92cyyUEGiMfVsj
	 QWmSFMDc/YdUlc8YKeq95Y2IIfdDcKFSt5yGaz1NcbxJnkGT4mHUcCy4CCF7LQN4/v
	 zWSoTp5JdgrpwvxDlhGjE1Qo6hd+Ric1aBOPY8fkAnSiWq/wrY7vBzC53gJVtJYSrT
	 lOEUeVxAOJyTE2qhmqbrbIJ53kp2zWYvACwWLp5/ihzHjQF3411A2E0HjDXDqzT9wk
	 /2narfI5nizdt/T/iEitS9O+fXNc42o2S5Ty16IzXN6ujOJyLE87qaZnxXaAXqrf/f
	 cj55wx5/Vhx4w==
Date: Thu, 3 Aug 2023 21:39:15 +0200
From: Simon Horman <horms@kernel.org>
To: Yue Haibing <yuehaibing@huawei.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, netdev@vger.kernel.org
Subject: Re: [PATCH net-next] net: llc: Remove unused function declarations
Message-ID: <ZMwCY36HiPDiMwGl@kernel.org>
References: <20230803134747.41512-1-yuehaibing@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230803134747.41512-1-yuehaibing@huawei.com>

On Thu, Aug 03, 2023 at 09:47:47PM +0800, Yue Haibing wrote:
> llc_conn_ac_send_i_rsp_as_ack() and llc_conn_ev_sendack_tmr_exp()
> are never implemented since beginning of git history.
> 
> Signed-off-by: Yue Haibing <yuehaibing@huawei.com>

Reviewed-by: Simon Horman <horms@kernel.org>


