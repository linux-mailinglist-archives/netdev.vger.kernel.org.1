Return-Path: <netdev+bounces-57723-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D40F813FE0
	for <lists+netdev@lfdr.de>; Fri, 15 Dec 2023 03:35:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 27A411F22C83
	for <lists+netdev@lfdr.de>; Fri, 15 Dec 2023 02:35:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3B0818F;
	Fri, 15 Dec 2023 02:35:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HCihW2+g"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 545F510E1
	for <netdev@vger.kernel.org>; Fri, 15 Dec 2023 02:35:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-1d32c5ce32eso10190715ad.0
        for <netdev@vger.kernel.org>; Thu, 14 Dec 2023 18:35:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702607740; x=1703212540; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=34/xqjgB4URTGUuwfdQv0WCU7hZvYJC2hh0EYawTBF0=;
        b=HCihW2+ggK4mWHTKLDhaXOEKVps4nkC0pYH7bBnDQXMusd2EQiiaJ/d5N3JNRaVC5+
         L5Jd8NneEyn5OS3AqfYF3YMHxt7ciSfFu75GjtlSD9l0bMKIkK6oAoQwisSteVZBQ2Hq
         x3W0mydOTY3Gq4cKlyllOiNPVhFm4S9SdWCkG8Dnv9JecrcqtoEwhpai42g+a9hh5DCA
         At1o7Nlj2NgYbY8BGJQcaeof9usxCdIU7mgkzVQFG/qIpDMZ+MVOuZzQ5DfyI1EZ4yIu
         6Hqkj2jaET3RdYJAjCoTIpa6O+j2PaDk+QzOLVZWwUj8onw9TQL5fElbphJ9DOZtxmI5
         CfLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702607740; x=1703212540;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=34/xqjgB4URTGUuwfdQv0WCU7hZvYJC2hh0EYawTBF0=;
        b=jW3rxd+WPPFbR53995q+Y07oM9rxNJ3Xv1SKXu2Edpi+vYdhdqQd+64SQyKb4ADvXu
         c6cs9wGwpVYwLV52oeRsUVDWOzUY0qU2nPDggIyuLIJnl/rLZobZuEliJtMk/LHmlnSj
         XDlOIPT9MmoWNj/Cd27w+Le2gjmUInvfamCGv10h/f0FQlHteVhPy7JSFJkRGiKqaJBi
         246slVgjYMd1/W9pO4icig07obDB+syvCNirUA+5HXIWPpFB3VPTXq1XPkGoVBaXhFkq
         JH8eW+bTUlZ0rfxC6o+mEhFkU+DizaKNTi6DSlj7qxGOo/INLTald8A5yJihGhS56dIS
         C/KQ==
X-Gm-Message-State: AOJu0YwplgvOEpwYxIdgbsf3BgbKA7AXfy4DSTj4pjxD59hxpNAoRnUJ
	0HxreQZscr0lPl8p7W/jwnY=
X-Google-Smtp-Source: AGHT+IEaL7SQCxJX4xqpX2JJrVh0Ebs1xSPh48+1OqMON1nqm0948HkV6pQbmpOJrzOlYZP+WtXowg==
X-Received: by 2002:a17:902:b091:b0:1d3:51df:22f2 with SMTP id p17-20020a170902b09100b001d351df22f2mr3479948plr.54.1702607739606;
        Thu, 14 Dec 2023 18:35:39 -0800 (PST)
Received: from Laptop-X1 ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id x14-20020a170902820e00b001d2ffeac9d3sm1865612pln.186.2023.12.14.18.35.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Dec 2023 18:35:39 -0800 (PST)
Date: Fri, 15 Dec 2023 10:35:32 +0800
From: Hangbin Liu <liuhangbin@gmail.com>
To: Benjamin Poirier <benjamin.poirier@gmail.com>
Cc: Patrice Duroux <patrice.duroux@gmail.com>,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
	Petr Machata <petrm@nvidia.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, Shuah Khan <shuah@kernel.org>,
	mlxsw@nvidia.com, Jay Vosburgh <j.vosburgh@gmail.com>
Subject: Re: [PATCH net-next] selftests: forwarding: Import top-level lib.sh
 through $lib_dir
Message-ID: <ZXu7dGj7F9Ng8iIX@Laptop-X1>
References: <a1c56680a5041ae337a6a44a7091bd8f781c1970.1702295081.git.petrm@nvidia.com>
 <ZXcERjbKl2JFClEz@Laptop-X1>
 <87fs07mi0w.fsf@nvidia.com>
 <ZXi_veDs_NMDsFrD@d3>
 <ZXlIew7PbTglpUmV@Laptop-X1>
 <ZXok5cRZDKdjX1nj@d3>
 <ZXqpieBoynMk0U-Z@Laptop-X1>
 <ZXt6_4WCxYoxgWqL@d3>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZXt6_4WCxYoxgWqL@d3>

On Thu, Dec 14, 2023 at 05:00:31PM -0500, Benjamin Poirier wrote:
> I started to make the adjustments to all the tests but I got stuck on
> the dsa tests. The problem is that the tests which are symlinked (like
> bridge_locked_port.sh) expect to source lib.sh (net/forwarding/lib.sh)
> from the same directory. That lib.sh then expects to source net/lib.sh
> from the parent directory. Because `rsync --copy-unsafe-links` is used,
> all those links become regular files after export so we can't rely on
> `readlink -f`.
> 
> Honestly, given how the dsa tests are organized, I don't see a clean way
> to support these tests without error after commit 25ae948b4478
> ("selftests/net: add lib.sh").

No worry, the last way is just make net/forwarding/lib.sh not source net/lib.sh :)
Although this would make us copy a lot functions from net/forwarding/lib.sh to
source net/lib.sh. So before that, let's try if we can

Move all the dsa tests back to net/forwarding (actually only needed for
test_bridge_fdb_stress.sh). And add a forwarding.config.dsa.sample. Maybe
a test list for dsa testing. But with this way the dsa testing will not
able to run via run_kselftest.sh.

Or, we can remove the symlinks, and add the dsa tests with exec the relative
forwarding path's tests directly. e.g.

### in das test folder

$ cat bridge_mld.sh
#!/bin/bash
../../../net/forwarding/bridge_mld.sh

$ cat Makefile
# SPDX-License-Identifier: GPL-2.0+ OR MIT

TEST_PROGS = \
        bridge_mld.sh

TEST_SH_LIBS := \
        net/lib.sh \
        net/forwarding/lib.sh \
        net/forwarding/bridge_mld.sh

TEST_FILES := forwarding.config

include ../../../lib.mk

### for net/forwarding/lib.sh looks we need source the ${PWD}/forwarding.config if run via run_kselftest.sh

if [[ -f ${PWD}/forwarding.config ]]; then
        source "$PWD/forwarding.config"
elif [[ -f $relative_path/forwarding.config ]]; then
        source "$relative_path/forwarding.config"
fi

What do you think?

Thanks
Hangbin

