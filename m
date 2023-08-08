Return-Path: <netdev+bounces-25553-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 23CA5774AA4
	for <lists+netdev@lfdr.de>; Tue,  8 Aug 2023 22:32:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DB0CF28140D
	for <lists+netdev@lfdr.de>; Tue,  8 Aug 2023 20:32:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64B0F14F71;
	Tue,  8 Aug 2023 20:32:37 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 542E0171C3
	for <netdev@vger.kernel.org>; Tue,  8 Aug 2023 20:32:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30842C433C7;
	Tue,  8 Aug 2023 20:32:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1691526755;
	bh=rLh9KTm+D+tIGU0WVN/UGtE6ynPOBL9uPiN5snTuX8s=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=C3E0NhLfcS5yhkIm8vEdQ42aADDhK2VGyaBFEEpiV91cEi1yMEqgLLGRwFS+11Fxw
	 5DpOWfVNMZgV+3a+Riu0OdMl7Ssy74tSYJ5MDuvFioSpEtHZ+Hn6nqJU3Of5cI32vQ
	 gyO/jWduBH0w7JE+6CE7vkl92LAUsDuwixv3kTOIOV95SuMMz2ABYx5o1xLSraWhva
	 m1CaPD0yhmA/0XCFAC/JmbKgMUTws1e22skQIbbSyXSvTuXwi94rQ9qt1utv1ldW+M
	 5Mg/gWP4AKhezXxuGSjJpdCnm3KIKXgOIqaCWzIbP9FEy9DZwM7dlrG3FjcdgtqBkW
	 GckyL3BJgEbtw==
Date: Tue, 8 Aug 2023 13:32:34 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Tony Nguyen <anthony.l.nguyen@intel.com>
Cc: davem@davemloft.net, pabeni@redhat.com, edumazet@google.com,
 netdev@vger.kernel.org, pavan.kumar.linga@intel.com,
 emil.s.tantilov@intel.com, jesse.brandeburg@intel.com,
 sridhar.samudrala@intel.com, shiraz.saleem@intel.com,
 sindhu.devale@intel.com, willemb@google.com, decot@google.com,
 andrew@lunn.ch, leon@kernel.org, mst@redhat.com, simon.horman@corigine.com,
 shannon.nelson@amd.com, stephen@networkplumber.org
Subject: Re: [PATCH net-next v4 00/15][pull request] Introduce Intel IDPF
 driver
Message-ID: <20230808133234.78504bca@kernel.org>
In-Reply-To: <20230808003416.3805142-1-anthony.l.nguyen@intel.com>
References: <20230808003416.3805142-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon,  7 Aug 2023 17:34:01 -0700 Tony Nguyen wrote:
> This patch series introduces the Intel Infrastructure Data Path Function
> (IDPF) driver. It is used for both physical and virtual functions. Except
> for some of the device operations the rest of the functionality is the
> same for both PF and VF. IDPF uses virtchnl version2 opcodes and
> structures defined in the virtchnl2 header file which helps the driver
> to learn the capabilities and register offsets from the device
> Control Plane (CP) instead of assuming the default values.

Patches 4 and 10 add kdoc warnings, please fix those.
And double check all the checkpatch warning about lines > 80 chars.
-- 
pw-bot: cr

