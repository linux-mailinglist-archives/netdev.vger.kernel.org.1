Return-Path: <netdev+bounces-24350-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AA00376FE76
	for <lists+netdev@lfdr.de>; Fri,  4 Aug 2023 12:28:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 63A8928259A
	for <lists+netdev@lfdr.de>; Fri,  4 Aug 2023 10:28:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5211AAD34;
	Fri,  4 Aug 2023 10:28:23 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA97CAD23
	for <netdev@vger.kernel.org>; Fri,  4 Aug 2023 10:28:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83A5CC433C8;
	Fri,  4 Aug 2023 10:28:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1691144901;
	bh=QoEsYNbjsFFAbciklJ7lF0/x8SccEJnHPlvLfQ6xsLE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=uFbH5vBM8CBeZgwU32UOseiNmn3vZkQ2Q01WdpbKuXu4YKCK8JcQmlUGtpdhm1Z2i
	 azg1TGfXTlwawzDxzBwx/Kgwyz8Te9nSyOIv1gOUMX9JdGlAyd7xjJXL6/P4Q1Vs14
	 846YHdjwSi8nlPFXzdar6pH72nZUU9mCJfEG2Vr0=
Date: Fri, 4 Aug 2023 12:28:18 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Ashwin Dayanand Kamat <kashwindayan@vmware.com>
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	Wen Gong <wgong@codeaurora.org>,
	Jouni Malinen <jouni@codeaurora.org>,
	Johannes Berg <johannes.berg@intel.com>, davem@davemloft.net,
	ath10k@lists.infradead.org, linux-wireless@vger.kernel.org,
	netdev@vger.kernel.org, akaher@vmware.com, vsirnapalli@vmware.com,
	tkundu@vmware.com, namit@vmware.com
Subject: Re: [PATCH v4.19.y] ath10k: Fix TKIP Michael MIC verification for
 PCIe
Message-ID: <2023080408-squad-pony-2638@gregkh>
References: <1690971733-22270-1-git-send-email-kashwindayan@vmware.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1690971733-22270-1-git-send-email-kashwindayan@vmware.com>

On Wed, Aug 02, 2023 at 03:52:13PM +0530, Ashwin Dayanand Kamat wrote:
> From: Wen Gong <wgong@codeaurora.org>
> 
> commit 0dc267b13f3a7e8424a898815dd357211b737330 upstream.
> 
> TKIP Michael MIC was not verified properly for PCIe cases since the
> validation steps in ieee80211_rx_h_michael_mic_verify() in mac80211 did
> not get fully executed due to unexpected flag values in
> ieee80211_rx_status.
> 
> Fix this by setting the flags property to meet mac80211 expectations for
> performing Michael MIC validation there. This fixes CVE-2020-26141. It
> does the same as ath10k_htt_rx_proc_rx_ind_hl() for SDIO which passed
> MIC verification case. This applies only to QCA6174/QCA9377 PCIe.
> 
> Tested-on: QCA6174 hw3.2 PCI WLAN.RM.4.4.1-00110-QCARMSWP-1
> 
> Cc: stable@vger.kernel.org
> Signed-off-by: Wen Gong <wgong@codeaurora.org>
> Signed-off-by: Jouni Malinen <jouni@codeaurora.org>
> Link: https://lore.kernel.org/r/20210511200110.c3f1d42c6746.I795593fcaae941c471425b8c7d5f7bb185d29142@changeid
> Signed-off-by: Johannes Berg <johannes.berg@intel.com>
> Signed-off-by: Ashwin Dayanand Kamat <kashwindayan@vmware.com>
> ---
>  drivers/net/wireless/ath/ath10k/htt_rx.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 

Now queued up, thanks.

greg k-h

