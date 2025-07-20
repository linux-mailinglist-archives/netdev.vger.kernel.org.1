Return-Path: <netdev+bounces-208404-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D4D3B0B4EA
	for <lists+netdev@lfdr.de>; Sun, 20 Jul 2025 12:38:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 973613BF7CC
	for <lists+netdev@lfdr.de>; Sun, 20 Jul 2025 10:37:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DF211EBFE0;
	Sun, 20 Jul 2025 10:37:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oVPi+kP0"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A56212D1F1
	for <netdev@vger.kernel.org>; Sun, 20 Jul 2025 10:37:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753007877; cv=none; b=mzpBlZOuCXvtzL4ZzpOevwmDtaG9MpmY+8hJUUNlYQM8GdRxcH/ctjfu8unO2NwI/xl4qUm11uvdLpBkucYJSBZFzhtEK+inNhTgoyZjPa1uF4vt0YOlgyqbjaGippXG4F0IfC4drW4e4ek27sm51VvMk1bTP5LCEJbSTsOcDMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753007877; c=relaxed/simple;
	bh=WWnxhKr2LsNSBFrIU5bIngNXeq/OvgvIgFegHaekTwU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l+PtaDbqX+BKNqYzTGIbTLrTulCjwY/IZ4xcCGXxKPYvpXi6ZtD/d+nH8c5LcVGgzVkb9K7rEcYfY+W2lpmw538oioZuUjcDb8RWXuUqiB8Hx47j2UPjufWmWJZegBr3iuJWvhNegBjB/TfdewNi65cxY1BwN4ccXdq+NxwolhY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oVPi+kP0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE3B2C4CEE7;
	Sun, 20 Jul 2025 10:37:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753007876;
	bh=WWnxhKr2LsNSBFrIU5bIngNXeq/OvgvIgFegHaekTwU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=oVPi+kP0pnYQB4HIRaw0qTgo9kne3RIbKb/W6YulaivNFMVsSgT+d4qC0Cls6Rq2w
	 VzJLvMhCWlQjtFW+szdmxqAzuYH2AYLGgPX9XwX0+VUDSGRCpvJEeWFEHqc1YG/PlF
	 DleV1avstOSSWmrvpI1PpjTYwGhUlGdHouRT3lQUEWS2LukfHbQAdMP30Hwm97P/go
	 k4YtzGYQ7nQxfl7YbGXVdU4+f20PkZBs3OWMKkBLsKBT8FKqBG5hqpGLYVJ9kSYIbK
	 Z/0nrmVLM3vxmhAzwoNlsWeSu9aqh3MhUmLU6nFbRkoKZszADcoBsnmFaHVR7VzVB6
	 qhUaFdOvReOjA==
Date: Sun, 20 Jul 2025 11:37:52 +0100
From: Simon Horman <horms@kernel.org>
To: David Wilder <wilder@us.ibm.com>
Cc: netdev@vger.kernel.org, jv@jvosburgh.net, pradeeps@linux.vnet.ibm.com,
	pradeep@us.ibm.com, i.maximets@ovn.org, amorenoz@redhat.com,
	haliu@redhat.com, stephen@networkplumber.org
Subject: Re: [PATCH net-next v6 7/7] bonding: Selftest and documentation for
 the arp_ip_target parameter.
Message-ID: <20250720103752.GT2459@horms.kernel.org>
References: <20250718212430.1968853-1-wilder@us.ibm.com>
 <20250718212430.1968853-8-wilder@us.ibm.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250718212430.1968853-8-wilder@us.ibm.com>

On Fri, Jul 18, 2025 at 02:23:43PM -0700, David Wilder wrote:
> This selftest provided a functional test for the arp_ip_target parameter
> both with and without user supplied vlan tags.
> 
> and
> 
> Updates to the bonding documentation.
> 
> Signed-off-by: David Wilder <wilder@us.ibm.com>
> ---
>  Documentation/networking/bonding.rst          |  11 ++
>  .../selftests/drivers/net/bonding/Makefile    |   3 +-
>  .../drivers/net/bonding/bond-arp-ip-target.sh | 178 ++++++++++++++++++

Hi David,

Recently we have started running shellcheck as part of our CI for Networking.

Excluding SC2317, which flagges code as unreachable due to
the structure of many sleftests, including this one, I think it is trivial
to make bond-arp-ip-target.sh selftest-clean.

As I see there will be a v7 anyway, could you take a look at doing so?

  $ shellcheck -e SC2317 ./tools/testing/selftests/drivers/net/bonding/bond-arp-ip-target.sh
  
  In ./tools/testing/selftests/drivers/net/bonding/bond-arp-ip-target.sh line 133:
                  if [ $RET -ne 0 ]; then
                       ^--^ SC2086 (info): Double quote to prevent globbing and word splitting.
  
  Did you mean: 
                  if [ "$RET" -ne 0 ]; then
  
  
  In ./tools/testing/selftests/drivers/net/bonding/bond-arp-ip-target.sh line 160:
                  if [ $RET -ne 0 ]; then
                       ^--^ SC2086 (info): Double quote to prevent globbing and word splitting.
  
  Did you mean: 
                  if [ "$RET" -ne 0 ]; then
  
  For more information:
    https://www.shellcheck.net/wiki/SC2086 -- Double quote to prevent globbing ...
  

And sorry for not flagging this earlier.
For some reason it seemed less clear to me the last time I checked.

