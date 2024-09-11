Return-Path: <netdev+bounces-127544-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E12C975B89
	for <lists+netdev@lfdr.de>; Wed, 11 Sep 2024 22:18:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7E85A1C21860
	for <lists+netdev@lfdr.de>; Wed, 11 Sep 2024 20:18:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C406918DF73;
	Wed, 11 Sep 2024 20:18:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="saCqdH6R"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DE447E583
	for <netdev@vger.kernel.org>; Wed, 11 Sep 2024 20:18:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726085880; cv=none; b=aMKaHurW+Ki/cYM7scDXtOstq5SSavLXJIe8WgUqxT+LIvBkmJZcQbpatx0hIsKCUZYPs0JY+rVXiudxdCC+cOSQoHCg+llQz+REWlXgZKMm9XDGcSq6qlhVF/ktvtq0flWYeKAd2/yjef4RiigJ42eeVCdN2K+G+JkhFtdi3OI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726085880; c=relaxed/simple;
	bh=CTabT7i2oEyeRmc3W/Gt8s4eqgemC3tWpgi5I+CEW8U=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Pi0jwAxB7F8Oz3teyLwcOR7H5W/RbS9ltNQbWetc1RP53XRfi1qzHgXQJHyQ4EJwfzEuN6AmOGxOD7plw6utcZHPDeJdsJRnhJX6Xd9YjjBKXpr8XaJKThrUlTeckT3bvnHyfYHgb10z1IMOEpWVMLT5jtZAFTRk+ejgK6/pElc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=saCqdH6R; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26701C4CEC0;
	Wed, 11 Sep 2024 20:18:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726085880;
	bh=CTabT7i2oEyeRmc3W/Gt8s4eqgemC3tWpgi5I+CEW8U=;
	h=From:To:Cc:Subject:Date:From;
	b=saCqdH6RpH5tyjIAB1XwLLWnxlRFYXJZbGcEjKDI6XyD3Q1ojPfG6kne17shTEd00
	 Zry0UrF5AnhZMhs0JOHxvpM9qNiPrZrpaNfYyXqY2wM9K9KBEDpOnvX4IUylRjgEZk
	 vdt0DE1noWuu7JcnFTLMiOzPOSjnpq5Q4r6bn9qEIj5wo8cTms8CkBUVOdzsYoNVzt
	 WP0AyUOgcH/s42AVxb/YJd3ywZHJ8/KuV9xe7BxloTjCXghAHUfjy0FXr0cRU86XK3
	 3CAgi3mIvLlk8MPyqXbDK11zUy1hGluC9Vynzf/uFHfS36ZHKpmPWfCy4Q6XAOkpU8
	 UNJJgjr5K/hmg==
From: Saeed Mahameed <saeed@kernel.org>
To: "David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>
Cc: Saeed Mahameed <saeedm@nvidia.com>,
	netdev@vger.kernel.org,
	Tariq Toukan <tariqt@nvidia.com>,
	Gal Pressman <gal@nvidia.com>,
	Leon Romanovsky <leonro@nvidia.com>
Subject: [pull request][net-next 00/15] mlx5 updates 2024-09-11
Date: Wed, 11 Sep 2024 13:17:42 -0700
Message-ID: <20240911201757.1505453-1-saeed@kernel.org>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Saeed Mahameed <saeedm@nvidia.com>

This series adds misc updates to mlx5 driver, including two fixes
requested by Jakub from previous pull.
For more information please see tag log below.

Please pull and let me know if there is any problem.

Thanks,
Saeed.


The following changes since commit bf73478b539b4a13e0b4e104c82fe3c2833db562:

  Merge branch 'lan743x-phylink' (2024-09-11 11:06:12 +0100)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/saeed/linux.git tags/mlx5-updates-2024-09-11

for you to fetch changes up to b499dee2426b12c7acccad546d880d601600c915:

  net/mlx5e: Match cleanup order in mlx5e_free_rq in reverse of mlx5e_alloc_rq (2024-09-11 13:16:03 -0700)

----------------------------------------------------------------
mlx5-updates-2024-09-11

Misc updates to mlx5 driver:

1) Fix HW steering ret value and align with kdoc
2) Flow steering cleanups and add support for no append at software level
3) Support for sync reset using hot reset
4) RX SW counter to cover no-split events in header/data split mode
5) Make affinity of SFs configurable

----------------------------------------------------------------
Dragos Tatulea (1):
      net/mlx5e: SHAMPO, Add no-split ethtool counters for header/data split

Mark Bloch (4):
      net/mlx5: fs, move hardware fte deletion function reset
      net/mlx5: fs, remove unused member
      net/mlx5: fs, separate action and destination into distinct struct
      net/mlx5: fs, add support for no append at software level

Moshe Shemesh (5):
      net/mlx5: fs, move steering common function to fs_cmd.h
      net/mlx5: fs, make get_root_namespace API function
      net/mlx5: Add device cap for supporting hot reset in sync reset flow
      net/mlx5: Add support for sync reset using hot reset
      net/mlx5: Skip HotPlug check on sync reset using hot reset

Rahul Rameshbabu (1):
      net/mlx5e: Match cleanup order in mlx5e_free_rq in reverse of mlx5e_alloc_rq

Shay Drory (2):
      net/mlx5: Allow users to configure affinity for SFs
      net/mlx5: Add NOT_READY command return status

Yevgeny Kliteynik (2):
      net/mlx5: HWS, updated API functions comments to kernel doc
      net/mlx5: HWS, fixed error flow return values of some functions

 .../ethernet/mellanox/mlx5/counters.rst            |  16 +
 drivers/net/ethernet/mellanox/mlx5/core/cmd.c      |   7 +-
 .../mellanox/mlx5/core/diag/fs_tracepoint.h        |   8 +-
 drivers/net/ethernet/mellanox/mlx5/core/en_main.c  |  25 +-
 drivers/net/ethernet/mellanox/mlx5/core/en_rx.c    |   3 +
 drivers/net/ethernet/mellanox/mlx5/core/en_stats.c |   6 +
 drivers/net/ethernet/mellanox/mlx5/core/en_stats.h |   4 +
 drivers/net/ethernet/mellanox/mlx5/core/eq.c       |   2 +-
 drivers/net/ethernet/mellanox/mlx5/core/fs_cmd.c   |  62 +-
 drivers/net/ethernet/mellanox/mlx5/core/fs_cmd.h   |   8 +
 drivers/net/ethernet/mellanox/mlx5/core/fs_core.c  | 315 +++++++--
 drivers/net/ethernet/mellanox/mlx5/core/fs_core.h  |  22 +-
 drivers/net/ethernet/mellanox/mlx5/core/fw_reset.c |  95 ++-
 drivers/net/ethernet/mellanox/mlx5/core/main.c     |   3 +
 .../ethernet/mellanox/mlx5/core/steering/fs_dr.c   |  92 ++-
 .../mellanox/mlx5/core/steering/hws/mlx5hws.h      | 756 ++++++++++-----------
 .../mlx5/core/steering/hws/mlx5hws_matcher.c       |   2 +-
 .../mellanox/mlx5/core/steering/hws/mlx5hws_rule.c |   8 +-
 .../mlx5/core/steering/hws/mlx5hws_table.c         |   2 +-
 include/linux/mlx5/device.h                        |   1 +
 include/linux/mlx5/fs.h                            |   3 +
 include/linux/mlx5/mlx5_ifc.h                      |  11 +-
 22 files changed, 878 insertions(+), 573 deletions(-)

