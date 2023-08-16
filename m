Return-Path: <netdev+bounces-28248-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A4A3C77EC1D
	for <lists+netdev@lfdr.de>; Wed, 16 Aug 2023 23:45:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 80BE51C211D2
	for <lists+netdev@lfdr.de>; Wed, 16 Aug 2023 21:45:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E7291AA6B;
	Wed, 16 Aug 2023 21:45:19 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB19C15AE5
	for <netdev@vger.kernel.org>; Wed, 16 Aug 2023 21:45:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49EEFC433C7;
	Wed, 16 Aug 2023 21:45:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1692222317;
	bh=FjJQ3p3L3eCOYP4PSkk8u0kx6dsnOGxRl/CDOO3tYyA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hSH5hvzYYGtyaoIj4t79y+qQhdlp1pZqtXj+OR8/Gw7LPDoPONk4h7IidEVbJvkK4
	 aQZ1UOViIbHH5bccc8h1e0EuAm/u+mWcdrRghM0rqZvwBJVnM8Zeq7kIcKCLYvvxVZ
	 y1+1ZKwmJThchORtbv8kUXHgRZ2oQpu7oGOKR/xv58j9BkVFcmwOjkLXuxssmgM8zo
	 3RvDOabvQ/dUZe86voiH1qTDaKqzi0oCO+Er+ulAnC0ygsIJxs+eCzk7H6ppxkPDjS
	 pVqiQ8JjXFw7LEr7CseKTDBQxU4WC2LjjvFrQVXcR9fN4DW3k1C/Hfmg+Dk6PUi5l9
	 f03KQHJB6YXKg==
Date: Wed, 16 Aug 2023 14:45:15 -0700
From: Saeed Mahameed <saeed@kernel.org>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	linux-pci@vger.kernel.org, Saeed Mahameed <saeedm@nvidia.com>,
	Leon Romanovsky <leon@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Moshe Shemesh <moshe@mellanox.com>, netdev@vger.kernel.org,
	linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] net/mlx5: Convert PCI error values to generic errnos
Message-ID: <ZN1Da7oOOKQ/FnxI@x130>
References: <20230814132721.26608-1-ilpo.jarvinen@linux.intel.com>
 <20230814223232.GA195681@bhelgaas>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230814223232.GA195681@bhelgaas>

On 14 Aug 17:32, Bjorn Helgaas wrote:
>On Mon, Aug 14, 2023 at 04:27:20PM +0300, Ilpo Järvinen wrote:
>> mlx5_pci_link_toggle() returns mix PCI specific error codes and generic
>> errnos.
>>
>> Convert the PCI specific error values to generic errno using
>> pcibios_err_to_errno() before returning them.
>>
>> Fixes: eabe8e5e88f5 ("net/mlx5: Handle sync reset now event")
>> Fixes: 212b4d7251c1 ("net/mlx5: Wait for firmware to enable CRS before pci_restore_state")
>> Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
>>
>> ---
>>
>> Maintainers beware, this will conflict with read+write -> set/clear_word
>> fixes in pci.git/pcie-rmw. As such, it might be the easiest for Bjorn to
>> take it instead of net people.
>
>I provisionally rebased and applied it on pci/pcie-rmw.  Take a look
>and make sure I didn't botch it -- I also found a case in
>mlx5_check_dev_ids() that looks like it needs the same conversion.
>
>The commit as applied is below.
>
>If networking folks would prefer to take this, let me know and I can
>drop it.
>

I Just took this patch into my mlx5 submission queue and sent it to netdev
tree, please drop it from your tree.

Thanks for the patch,
Saeed.


