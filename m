Return-Path: <netdev+bounces-101966-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B2CC900CD9
	for <lists+netdev@lfdr.de>; Fri,  7 Jun 2024 22:24:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0B60DB2242D
	for <lists+netdev@lfdr.de>; Fri,  7 Jun 2024 20:24:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1323C14B076;
	Fri,  7 Jun 2024 20:24:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VbRDB7gp"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0197145B1A
	for <netdev@vger.kernel.org>; Fri,  7 Jun 2024 20:24:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717791846; cv=none; b=Qp72ar0528u7A/uMpdizzaAeXk6EIYd0KhuzP/k5h8+dGXT5V3v5xAVkw8kP/CNt+6wG7cX0o9Zu8aWf1NKnPTg7nmPY/hjnShIYHC1kdXRDhSdKrnKNeUNOuT+XjaLcHHlatL3qnQuI7JCKSQPVJHzgCVs0HbaFt7dXvM6w5TY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717791846; c=relaxed/simple;
	bh=E5rp6A4BLPmqX/miGKWCt3reklvJel12E+xRFyNJ5t0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=vCFVrXpTSsG0hoDJ2RPSGM0zc362o29UaF98UfHiD2EOwery+wZfH5mchhHFo46aQ1siK2hjYlZp2/PrwwsXCjbpF8djU0cmfH886qIpECeCDvTXiwscSJZAsCOPtGOh/GAyy03gABnz2ywpUjPiomNHgUNf9cK1S5eZqKe3vAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VbRDB7gp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC01CC2BBFC;
	Fri,  7 Jun 2024 20:24:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717791845;
	bh=E5rp6A4BLPmqX/miGKWCt3reklvJel12E+xRFyNJ5t0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VbRDB7gpJEO84oDzPoXPXT4rrcF0e0LcLvyaHNMM5+ESSKAtv/vws077+K8D1uI1d
	 vPhNDeUMUYIraTYZWF2Vm5peBXDoboK8Cvqx8vVYrU1JToj6bacVByoUcy1iXQFEEx
	 YBdThsEpEAtuWKvybAHiVC4+f1d7gytqxgEeHUKnGKDsZ6z6fl7MmPHP+QEqcT5xUb
	 msuKU9w5F4asT+4cbZ7BOyWBwvHB1tzcasn5Q3XNNpSWrtnnv8uCHaWqwu0w4f0ukN
	 xoC1+TcJk1svqAgpiJoI2UdfjZsOq7OJkmT34THhAux1YcPte12mRSfC0xy5b/Lo7d
	 9TS55i9NOlPDg==
Date: Fri, 7 Jun 2024 21:24:02 +0100
From: Simon Horman <horms@kernel.org>
To: allison.henderson@oracle.com
Cc: netdev@vger.kernel.org
Subject: Re: [RFC net-next 3/3] selftests: rds: add testing infrastructure
Message-ID: <20240607202402.GI27689@kernel.org>
References: <20240607003631.32484-1-allison.henderson@oracle.com>
 <20240607003631.32484-4-allison.henderson@oracle.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240607003631.32484-4-allison.henderson@oracle.com>

On Thu, Jun 06, 2024 at 05:36:31PM -0700, allison.henderson@oracle.com wrote:
> From: Vegard Nossum <vegard.nossum@oracle.com>
> 
> This adds some basic self-testing infrastructure for RDS.
> 
> Signed-off-by: Vegard Nossum <vegard.nossum@oracle.com>
> Signed-off-by: Allison Henderson <allison.henderson@oracle.com>
> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>

Hi Allison,

Some minor nits from my side.

> diff --git a/tools/testing/selftests/net/rds/config.sh b/tools/testing/selftests/net/rds/config.sh
> new file mode 100755
> index 000000000000..c2c36756ba1f
> --- /dev/null
> +++ b/tools/testing/selftests/net/rds/config.sh
> @@ -0,0 +1,33 @@
> +# SPDX-License-Identifier: GPL-2.0
> +#! /bin/bash

#! line needs to be the first line for it to take effect

Flagged by shellcheck.

https://www.shellcheck.net/wiki/SC1128

> +
> +set -e
> +set -u
> +set -x
> +
> +unset KBUILD_OUTPUT
> +
> +# start with a default config
> +make defconfig
> +
> +# no modules
> +scripts/config --disable CONFIG_MODULES
> +
> +# enable RDS
> +scripts/config --enable CONFIG_RDS
> +scripts/config --enable CONFIG_RDS_TCP
> +
> +# instrument RDS and only RDS
> +scripts/config --enable CONFIG_GCOV_KERNEL
> +scripts/config --disable GCOV_PROFILE_ALL
> +scripts/config --enable GCOV_PROFILE_RDS
> +
> +# need network namespaces to run tests with veth network interfaces
> +scripts/config --enable CONFIG_NET_NS
> +scripts/config --enable CONFIG_VETH
> +
> +# simulate packet loss
> +scripts/config --enable CONFIG_NET_SCH_NETEM
> +
> +# generate real .config without asking any questions
> +make olddefconfig
> diff --git a/tools/testing/selftests/net/rds/init.sh b/tools/testing/selftests/net/rds/init.sh
> new file mode 100755
> index 000000000000..a29e3de81ed5
> --- /dev/null
> +++ b/tools/testing/selftests/net/rds/init.sh
> @@ -0,0 +1,49 @@
> +#! /bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +
> +set -e
> +set -u
> +
> +LOG_DIR=/tmp
> +PY_CMD="/usr/bin/python3"
> +while getopts "d:p:" opt; do
> +  case ${opt} in
> +    d)
> +      LOG_DIR=${OPTARG}
> +      ;;
> +    p)
> +      PY_CMD=${OPTARG}
> +      ;;
> +    :)
> +      echo "USAGE: init.sh [-d logdir] [-p python_cmd]"
> +      exit 1
> +      ;;
> +    ?)
> +      echo "Invalid option: -${OPTARG}."
> +      exit 1
> +      ;;
> +  esac
> +done
> +
> +LOG_FILE=$LOG_DIR/rds-strace.txt
> +
> +mount -t proc none /proc
> +mount -t sysfs none /sys
> +mount -t tmpfs none /var/run
> +mount -t debugfs none /sys/kernel/debug
> +
> +echo running RDS tests...
> +echo Traces will be logged to $LOG_FILE
> +rm -f $LOG_FILE
> +strace -T -tt -o "$LOG_FILE" $PY_CMD $(dirname "$0")/test.py -d "$LOG_DIR" || true

Perhaps it can't occur, but I don't think this will behave as
expected if the out put of dirname includes spaces.

Flagged by shellecheck.
https://www.shellcheck.net/wiki/SC2046

Also, $LOG_DIR is quoted here, but not elsewhere, which seems inconsistent.

> +
> +echo saving coverage data...
> +(set +x; cd /sys/kernel/debug/gcov; find * -name '*.gcda' | \

shellcheck warns that:

SC2035 (info): Use ./*glob* or -- *glob* so names with dashes won't become options. 

https://www.shellcheck.net/wiki/SC2035

Although I guess in practice there are no filenames with dashes in
that directory.

> +while read f
> +do
> +	cat < /sys/kernel/debug/gcov/$f > /$f

Again, I guess it doesn't occur in practice.
But should $f be quoted in case it includes whitespace?

> +done)
> +
> +dmesg > $LOG_DIR/dmesg.out
> +
> +/usr/sbin/poweroff --no-wtmp --force

...

