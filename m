Return-Path: <netdev+bounces-37330-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 268747B4D91
	for <lists+netdev@lfdr.de>; Mon,  2 Oct 2023 10:48:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id 61E3B281E43
	for <lists+netdev@lfdr.de>; Mon,  2 Oct 2023 08:48:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6C6F567E;
	Mon,  2 Oct 2023 08:48:04 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A67B2567C
	for <netdev@vger.kernel.org>; Mon,  2 Oct 2023 08:48:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9CBCC433CA;
	Mon,  2 Oct 2023 08:48:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1696236484;
	bh=XOGfDme2Cyeh/OHASdTs/HM2Knh8BBK+/6eoqIaikIU=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=ndcCCsQ2Kft3AH+fLlCQ2W5kVYRDuQtzVXSiVrQgYg7N77ezzL5+B3KRpkuDWt+pd
	 Q5ju15yR0ojturo1iwg3oxp4q2erzCdNeqn1l9fdum0Db8AOHFsE5Zhuyz7quFGT74
	 ZKXNGfhGD6pKH0hHvHZkUHhmNSPTU5zuqJiaDXb61NPCh2kRD7c0RjuhWH3qdpfKAp
	 wppmzbK2TBnPNG4dssgC03HumnF9aeGPgayBkYKTMQ38xxc/c5DtCrjurcSrm6nkPs
	 KhbI2IABb+UgUqwNShvHzEZZL6IBqoCRNZRYX+H8hmO8OO4maMRL7o5tjosycimJMW
	 jIaKoFUOXdC/Q==
From: Leon Romanovsky <leon@kernel.org>
To: Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>
Cc: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 linux-rdma@vger.kernel.org, Mark Bloch <mbloch@nvidia.com>,
 netdev@vger.kernel.org, Paolo Abeni <pabeni@redhat.com>,
 Patrisious Haddad <phaddad@nvidia.com>, Saeed Mahameed <saeedm@nvidia.com>,
 Steffen Klassert <steffen.klassert@secunet.com>,
 Simon Horman <horms@kernel.org>, Leon Romanovsky <leon@kernel.org>
In-Reply-To: <cover.1695296682.git.leon@kernel.org>
References: <cover.1695296682.git.leon@kernel.org>
Subject: Re: [PATCH mlx5-next 0/9] Support IPsec packet offload in multiport
 RoCE devices
Message-Id: <169623648084.22791.13771441990752696500.b4-ty@kernel.org>
Date: Mon, 02 Oct 2023 11:48:00 +0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12-dev-a055d


On Thu, 21 Sep 2023 15:10:26 +0300, Leon Romanovsky wrote:
> This series from Patrisious extends mlx5 to support IPsec packet offload
> in multiport devices (MPV, see [1] for more details).
> 
> These devices have single flow steering logic and two netdev interfaces,
> which require extra logic to manage IPsec configurations as they performed
> on netdevs.
> 
> [...]

Applied, thanks!

[1/9] RDMA/mlx5: Send events from IB driver about device affiliation state
      https://git.kernel.org/rdma/rdma/c/0d293714ac3265
[2/9] net/mlx5: Register mlx5e priv to devcom in MPV mode
      https://git.kernel.org/rdma/rdma/c/bf11485f8419f9
[3/9] net/mlx5: Store devcom pointer inside IPsec RoCE
      https://git.kernel.org/rdma/rdma/c/eff5b663a6c304
[4/9] net/mlx5: Add alias flow table bits
      https://git.kernel.org/rdma/rdma/c/ef36ffcb381096
[5/9] net/mlx5: Implement alias object allow and create functions
      https://git.kernel.org/rdma/rdma/c/8c894f88c479e4
[6/9] net/mlx5: Add create alias flow table function to ipsec roce
      https://git.kernel.org/rdma/rdma/c/69c08efcbe7fa8
[7/9] net/mlx5: Configure IPsec steering for egress RoCEv2 MPV traffic
      https://git.kernel.org/rdma/rdma/c/dfbd229abeee76
[8/9] net/mlx5: Configure IPsec steering for ingress RoCEv2 MPV traffic
      https://git.kernel.org/rdma/rdma/c/f2f0231cfe8905
[9/9] net/mlx5: Handle IPsec steering upon master unbind/bind
      https://git.kernel.org/rdma/rdma/c/82f9378c443c20

Best regards,
-- 
Leon Romanovsky <leon@kernel.org>

