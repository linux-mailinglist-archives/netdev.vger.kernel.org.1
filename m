Return-Path: <netdev+bounces-81562-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E82F88A423
	for <lists+netdev@lfdr.de>; Mon, 25 Mar 2024 15:19:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 386C82E1F08
	for <lists+netdev@lfdr.de>; Mon, 25 Mar 2024 14:19:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18A5613248E;
	Mon, 25 Mar 2024 10:47:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YjW/FD99"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A59C182779
	for <netdev@vger.kernel.org>; Mon, 25 Mar 2024 10:16:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711361788; cv=none; b=XeyinZKS9Vea/Bfz1Ej5ELjyvS1631LQAl5h8kSkWL+h7RM87WWukXslstoQlQxeUtjlFGTWbWzf0CxstH0nI85pySqPQWex4nV9urMEmWVwzqxfwkj7dOAYBpd9LFMRYt+joi5uQ03JIPiP6INF6Vw2DvdYdNveR0Nr8KTozKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711361788; c=relaxed/simple;
	bh=eqfeLe+mLBn7xK4B9EUGIJ6rKwujXpsvi5InFJnb1fQ=;
	h=Content-Type:MIME-Version:In-Reply-To:References:Subject:From:Cc:
	 To:Date:Message-ID; b=EyECEKleJv5ZGF1m4B73LOVf3ZLElVapSNH1/C1NMpL3XjQugGNuzieCcchKdD6VMULJRGVWVSUqzLSgFKNctTrb5js3ySZ5vDxhT7jBS2f+SA8Cm3xAQNhCykyDqhCbXPDykVoRcjiTbODbMcrOlZNZIKlbdF147y14JhdaAZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YjW/FD99; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A090C433F1;
	Mon, 25 Mar 2024 10:16:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711361787;
	bh=eqfeLe+mLBn7xK4B9EUGIJ6rKwujXpsvi5InFJnb1fQ=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
	b=YjW/FD99drXS8yjUfT7MjCFRMTtUzQr+OJS+ue5x/43e0ciBSB1xj4JuccjtH5rjA
	 aWX7NncUgiKS398/sDZoucLEOKlAW3tJReulmKmHjaSGeX2LrauLR73vkTPJkIwCoo
	 RNzbRdg/ww0FpuEudvl1CwPNYg301dWa3K4Xkr6qsdZBRWWVoOvQldQgjwHeb6hVqP
	 kh0/FI5faa9jeidj59KZmDfoxt+9eCgXfI0GyzDMF8U7rgP9tUVLNtaQmpkT3c1ZZ5
	 hokyS7qiDUdsaWEz+M/WUq6GPIwU5M26P0yFMPk5TIsrpxOQ3NKF2+D6Qp+PxOUvfo
	 Ija9rz4gqYBaA==
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20240322155550.3779c85a@kernel.org>
References: <20240322114624.160306-1-atenart@kernel.org> <20240322155550.3779c85a@kernel.org>
Subject: Re: [PATCH net v3 0/4] gro: various fixes related to UDP tunnels
From: Antoine Tenart <atenart@kernel.org>
Cc: davem@davemloft.net, pabeni@redhat.com, edumazet@google.com, steffen.klassert@secunet.com, willemdebruijn.kernel@gmail.com, netdev@vger.kernel.org
To: Jakub Kicinski <kuba@kernel.org>
Date: Mon, 25 Mar 2024 11:16:24 +0100
Message-ID: <171136178469.5526.13954285367211651380@kwain>

Quoting Jakub Kicinski (2024-03-22 23:55:50)
> On Fri, 22 Mar 2024 12:46:19 +0100 Antoine Tenart wrote:
> > We found issues when a UDP tunnel endpoint is in a different netns than
> > where UDP GRO happens. This kind of setup is actually quite diverse,
> > from having one leg of the tunnel on a remove host, to having a tunnel
> > between netns (eg. being bridged in another one or on the host). In our
> > case that UDP tunnel was geneve.
>=20
> I think this series makes net/udpgro_fwd.sh selftest fail.

Thanks! Sorry for not checking this earlier...

What happens is the vxlan tunnel tests expect GRO to happen at the veth
level which is exactly the issues this series is fixing.

The below diff should fix the tests. I think it's good to keep them to
ensure GRO is actually not happening while packets are in an UDP tunnel;
I also removed the "UDP tunnel fwd perf" test as it's not providing any
useful data now IMO.

diff --git a/tools/testing/selftests/net/udpgro_fwd.sh b/tools/testing/self=
tests/net/udpgro_fwd.sh
index 380cb15e942e..83ed987cff34 100755
--- a/tools/testing/selftests/net/udpgro_fwd.sh
+++ b/tools/testing/selftests/net/udpgro_fwd.sh
@@ -244,7 +244,7 @@ for family in 4 6; do
        create_vxlan_pair
        ip netns exec $NS_DST ethtool -K veth$DST generic-receive-offload on
        ip netns exec $NS_DST ethtool -K veth$DST rx-gro-list on
-       run_test "GRO frag list over UDP tunnel" $OL_NET$DST 1 1
+       run_test "GRO frag list over UDP tunnel" $OL_NET$DST 10 10
        cleanup
=20
        # use NAT to circumvent GRO FWD check
@@ -258,13 +258,7 @@ for family in 4 6; do
        # load arp cache before running the test to reduce the amount of
        # stray traffic on top of the UDP tunnel
        ip netns exec $NS_SRC $PING -q -c 1 $OL_NET$DST_NAT >/dev/null
-       run_test "GRO fwd over UDP tunnel" $OL_NET$DST_NAT 1 1 $OL_NET$DST
-       cleanup
-
-       create_vxlan_pair
-       run_bench "UDP tunnel fwd perf" $OL_NET$DST
-       ip netns exec $NS_DST ethtool -K veth$DST rx-udp-gro-forwarding on
-       run_bench "UDP tunnel GRO fwd perf" $OL_NET$DST
+       run_test "GRO fwd over UDP tunnel" $OL_NET$DST_NAT 10 10 $OL_NET$DST
        cleanup
 done

