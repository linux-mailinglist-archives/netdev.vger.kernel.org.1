Return-Path: <netdev+bounces-56663-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 947F4810666
	for <lists+netdev@lfdr.de>; Wed, 13 Dec 2023 01:18:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 45CBF1F212EC
	for <lists+netdev@lfdr.de>; Wed, 13 Dec 2023 00:18:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64C8138B;
	Wed, 13 Dec 2023 00:18:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dr9wPktG"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 439C8631;
	Wed, 13 Dec 2023 00:18:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60051C433C8;
	Wed, 13 Dec 2023 00:18:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702426688;
	bh=m+cHguxWUL/fE2UPYWqUUiyfi0JooTA13AnTCZqPcxw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=dr9wPktGlD0sk+EXr4MqrRRjjHK5FseVi6VwmJxcd2T9uk5cTxUrZswOIEUyX+nxz
	 UJiPjkcUx9smWVTG94KE+E+3tfd5wU29TY2StTT8xylLk0bFZZUrb8WptsCNRi9IAK
	 Wq5RNcuiv3R6lEw7mWFSDKXbJiD0pNs8gfcHZIedohxq/77JDB2FJIrJXCvxUd+lL5
	 53/Q5ku8jPj73klycNm87+vW6k8sI7fS9S1BrQfB8+NSL+ZQ3dNSXQ2uQOb8cZc63X
	 FUpAVMxPXwWNvkZALoE4wweV/p94qG91nJVIqq1P1BlmSuMcVFIYwrNP+oL6dupWzM
	 wW+B0K0EKPdKQ==
Date: Tue, 12 Dec 2023 16:18:07 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Donald Hunter <donald.hunter@gmail.com>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Jonathan
 Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org, Jacob Keller
 <jacob.e.keller@intel.com>, Breno Leitao <leitao@debian.org>,
 donald.hunter@redhat.com
Subject: Re: [PATCH net-next v3 04/13] tools/net/ynl: Add 'sub-message'
 attribute decoding to ynl
Message-ID: <20231212161807.2260ce3a@kernel.org>
In-Reply-To: <20231212221552.3622-5-donald.hunter@gmail.com>
References: <20231212221552.3622-1-donald.hunter@gmail.com>
	<20231212221552.3622-5-donald.hunter@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 12 Dec 2023 22:15:43 +0000 Donald Hunter wrote:
> Implement the 'sub-message' attribute type in ynl.
> 
> Encode support is not yet implemented. Support for sub-message selectors
> at a different nest level from the key attribute is not yet supported.
> 
> Signed-off-by: Donald Hunter <donald.hunter@gmail.com>

Reviewed-by: Jakub Kicinski <kuba@kernel.org>

