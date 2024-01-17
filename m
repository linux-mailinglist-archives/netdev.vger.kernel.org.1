Return-Path: <netdev+bounces-63909-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5159D830094
	for <lists+netdev@lfdr.de>; Wed, 17 Jan 2024 08:37:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EC4432876E4
	for <lists+netdev@lfdr.de>; Wed, 17 Jan 2024 07:37:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 948F75CB0;
	Wed, 17 Jan 2024 07:37:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nR0MYUN0"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70686BE49
	for <netdev@vger.kernel.org>; Wed, 17 Jan 2024 07:37:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705477051; cv=none; b=T7EHEauTUOFkHvVQzpjwJNLhPwVA3Wd9rjabnznLIlqsGVj7Tis0yuHCU6/smJO7LPgXlcYZhBzMijLDuqgpHsgHTOA1wK8YX6y0hQ3ts493kZilr+YnIGsCTTvYUGqQEoT6Wz1VKBIBGLjO3cywqug81so8rVtInOsf4JQRwl8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705477051; c=relaxed/simple;
	bh=yh+3pews91Jw7ZHjnD/qw8VKB85XWMBP7QgBUAc3udQ=;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:
	 Content-Transfer-Encoding:In-Reply-To; b=ZkO5iLp7Sq8mqvcAc30S3CvUBgZrV2LDUcueOI2lrMGkyLFJp+yas7+OmlBvvV9n1iaRA9YHZPHsVH+JZlOBtM1aNi1bOcepciP2pwKAf9zGbCOagpMwFWVZcAi4gEgYoN/cP+f8BvDm20+1HDwXAYypsOH1z9Y6OhAzMCqnDOM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nR0MYUN0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C41FC433F1;
	Wed, 17 Jan 2024 07:37:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705477050;
	bh=yh+3pews91Jw7ZHjnD/qw8VKB85XWMBP7QgBUAc3udQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nR0MYUN0mUX9yGyB4RoT0Zvn3BGGzmj6lUNxliq/BZLiF1fa3Nuik1a1e+ono67Je
	 LV4fU30zK5cbmNjNLtPa6EZWIPJvozp2tuWfxS1lGFLVUCWxiTahJnSBozcx1h1vtX
	 SMtxLQsqQSuW5RsmCYwyCzLU6TU0SF4pS7XBlv6CwK6bvY0AMgbfSD86dEdiabd3aO
	 LWPFVDdtaFAipnMWltHoRwLv5A/zZxo6lDkjcaLvqDLrACaPCc7F3aP3K65mRPH7Sm
	 RrHpnfo8ogRAC66Yje3Q2gIH5sFaI7b2zoF0CZh9ryyKzFl7aNhGMX+O5LdNPynyUs
	 QrDe+KJuq2fNw==
Date: Tue, 16 Jan 2024 23:37:28 -0800
From: Saeed Mahameed <saeed@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: "Nelson, Shannon" <shannon.nelson@amd.com>,
	"David S. Miller" <davem@davemloft.net>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>,
	Saeed Mahameed <saeedm@nvidia.com>, netdev@vger.kernel.org,
	Tariq Toukan <tariqt@nvidia.com>, Armen Ratner <armeng@nvidia.com>,
	Daniel Jurgens <danielj@nvidia.com>
Subject: Re: [net-next 15/15] net/mlx5: Implement management PF Ethernet
 profile
Message-ID: <ZaeDuDSVFs46JffL@x130>
References: <20231221005721.186607-1-saeed@kernel.org>
 <20231221005721.186607-16-saeed@kernel.org>
 <dc44d1cc-0065-4852-8da6-20a4a719a1f3@amd.com>
 <ZYS7XdqqHi26toTN@x130>
 <20240104144446.1200b436@kernel.org>
 <ZZyDpJamg9gxDnym@x130>
 <20240108185806.6214cbe8@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240108185806.6214cbe8@kernel.org>

On 08 Jan 18:58, Jakub Kicinski wrote:
>On Mon, 8 Jan 2024 15:22:12 -0800 Saeed Mahameed wrote:
>> This is embedded core switchdev setup, there is no PF representor, only
>> uplink and VF/SF representors, the term management PF is only FW
>> terminology, since uplink traffic is controlled by the admin, and uplink
>> interface represents what goes in/out the wire, the current FW architecture
>> demands that BMC/NCSI traffic goes through a separate PF that is not the
>> uplink since the uplink rules are managed purely by the eswitch admin.
>
>"Normal way" to talk to the BMC is to send the traffic to the uplink
>and let the NC-SI filter "steal" the frames. There's not need for host
>PF (which I think is what you're referring to when you say there's
>no PF representor).
>
>Can you rephrase / draw a diagram? Perhaps I'm missing something.
>When the host is managing the eswitch for mlx5 AFAIU NC-SI frame
>stealing works fine.. so I'm missing what's different with the EC.

AFAIK it is not implemented via "stealing" from esw, esw is completely
managed by driver, FW has no access to it, the management PF completely
bypasses eswitch to talk to BMC in ConnectX arch.


    ┌─────────────┐            ┌─────────────┐
    │             │            │             │
    │             │            │            ┌┼────────────┐
    │     ┌───────┼────────────┼────────────┼│ mgmt PF    │
    │  BMC│       │ NC-SI      │   ConnectX └┼────────────┘
    │     │       │◄──────────►│             │
    │     │       │            │     NIC     │
    │     │       │            │            ┌┼────────────┐
    │     │       │            │      ┌─────┼│ PF         │
    │     │       │            │      │     └┼────────────┘
    │     │       │            │      │      │
    └─────▼───────┘            └──────▼──────┘
          │phy                        │ phy
          │                           │
          ▼                           ▼
      Management                     Network
        Network


