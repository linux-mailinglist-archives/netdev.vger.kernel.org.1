Return-Path: <netdev+bounces-276202-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GBC5LfON1Wk67gcAu9opvQ
	(envelope-from <netdev+bounces-276202-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 08 Apr 2026 01:06:27 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A7243B5675
	for <lists+netdev@lfdr.de>; Wed, 08 Apr 2026 01:06:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2688330210F9
	for <lists+netdev@lfdr.de>; Tue,  7 Apr 2026 23:06:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 142B738C427;
	Tue,  7 Apr 2026 23:06:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="NJEYa1N2"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EB5A38BF83
	for <netdev@vger.kernel.org>; Tue,  7 Apr 2026 23:06:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775603179; cv=pass; b=BweyX2WczaWwYfFofhl4xffx+iefPkTcwVrxGDBTaSbQiJa431y68Bwp/wgJdbXqSh+HWsrDmFpSdAPJuggazLlI5gHmtn0MZR4BXHAtCGzrTOeVFUH8/Mi6EbAB0L4F5egQjoS6CJNI8xSHvHijQLFzl4v6rGlOa0izapcbQUw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775603179; c=relaxed/simple;
	bh=eBBNZf+H2wH8bTLyUEgmWMro+6gVPpIYQxFPjJImcMc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DgFfjn6mMYF9TAiOlzCkd3OkSlgivoub/k4bCF3jGfl51ytXa8w6nmt3VhlmJenz3ifx1ta1H7IRiosO28Lg6o/ANKVV2T3oD17yW4s+Fht6z+pHc4Ds14+SLFhVOXkvdWli+597kjWVHkVosr1G1ekN2TtCdU9NGXrr6T9T/2w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=NJEYa1N2; arc=pass smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-66ba6d3dab3so4499a12.0
        for <netdev@vger.kernel.org>; Tue, 07 Apr 2026 16:06:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775603175; cv=none;
        d=google.com; s=arc-20240605;
        b=KCeItts24YhUeur9qIHTvE3rlyxT8SZEmF7yuSGTy3HBPMI7RcQtpkc6gjjAZl7QSw
         Wn7/c3e8b5SkIpKAvudE4x3xHIcUN/z7dROB9+rK1HkEdytSqUjl4ve0YDEqxwG25mmN
         0yEUdeH0oiyfC9yaJqLQ5gM8Oojt0GnwP6PneytOIk2+u0kG0l8SgMpwV05zcPXBcm6Y
         12xvyBwgN+KFidLGV2GLsMnPBaRnhmtLtILMZFG7+d3eHPf7ZUUr4SxECxGdD9ZGv5d/
         zAh9Jj6KcwimN96DS+ZvF41P5m8gjfcYB1I0bewunNdQLo3vvqig42YgtU81q1bpb4DO
         aYJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=QmF+mBJB5wkWwThlx9EWCJMVN4nWBYJprFHL0HGHAp8=;
        fh=waoJhWEsxyJzBmjtuOYGFwOF0Z5XyZzU02aYHcWkMos=;
        b=BYSz6AHTCyOLaPkH1/AmJiwAPGsRyiq5OhUcV277KwZ7seYjdNmIlg3fzVMZAT/CCJ
         7q2bUfvDm7ePE5jw/lmUtg9X7NVBqYd3wG2zPUjg8kAWdX6dbPWxkfXraUA1hmWkCGtO
         jpZC7wDJrgmgaNED7kdVT+pkcUQOVZYdWK70EDchUEu6e4gomhTXlZN2mRZuZ2c2IjfN
         PsZCvPUvO7PO9JF0ryDhClpUVten049eFD/N0OV5DkkX1mSPSed0wuWTAhK/Lpo+95zb
         IEw3JWIsoafU69O1DJcqGBNF0HUKN3zh4gRq5KtQMIHXtLrbUzjyZd1qsI3IqKAcK4yl
         AKOg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775603175; x=1776207975; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QmF+mBJB5wkWwThlx9EWCJMVN4nWBYJprFHL0HGHAp8=;
        b=NJEYa1N2cWh5gTJxM2PgA+HWpOnpWkwo48jxrz6DivWE7M/jUVAcxSAMFKEQHhdfyJ
         TOR6a8+ieqJqft60uyGxZijkGxia5Qs3OjmjDEPt7PkHbfmCM9DuhAjlIclqoFcnihs3
         BM7iaINKD2Pi4XVrLUiR/EBojbPzjiytuF7HgKJ1WkBPrKNb4j+MtbKUhs3qGItlPtrA
         Ribv376iNWvMtl0zaXH9GxoHQwHCQtwkeC+6ozl7np0Q+ip1lTgTLYWnK6v/6hQwpAM1
         CyIepAPTFOFMm7FugiMNYya2evaRlKci4mK5H21z/tO+W694mhSAtsEcXW++AqXATCr/
         Ketw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775603175; x=1776207975;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=QmF+mBJB5wkWwThlx9EWCJMVN4nWBYJprFHL0HGHAp8=;
        b=Ivxp49PQpjhrBdJeIyIo7V81Fm4QXQ3/Adn26xnV93JTljfGfoVxM1gOBG6eEIF1Dy
         y9DA6eufnNPvY4/B3Du2yj1GhnCFo0G99UwjBjqX/eivFn1A0ewnTa8g87FcT1uQf7Vx
         hUgQutk2zC3Rm7Ez0JBdFjzqqimQZRjE/4LrkzAXBs2ofmRF8+ZKfzT3Xz3BWSfSjrzF
         ot8/kQoedqvhClh46JoDYwVj+B6P4xC/4KjnwlWXgqlFs+rVmJNiIqguodfYwg/gSOuD
         At/+ZvGt6FlM8/pTsjYEzkWhPEMdNf0AJc4xnko5LfnD1lknTuvGVIKLJxAh+HSX5MJU
         8M2A==
X-Forwarded-Encrypted: i=1; AJvYcCW78c9M85EyL9/wD9qbDLqyZosCnVzvhTjlUBzVtCnyJcpuwirIRLFxaq53N1404uTvj32Yu1E=@vger.kernel.org
X-Gm-Message-State: AOJu0YxlUfFz5W95DHrc08zc8r20BK86H5g0C4BLZ3/Owfl6dbaz2F6W
	tltygramfRIcTON3az9EehwhwzgBmYKvcbtG9sr+/45oIoJXclsZHg46gR1UXU11oBGMux+925+
	pwlvoq6rAzEu6S3e0hfET6s4EWXEJHrQHPZoMSabp
X-Gm-Gg: AeBDiev7r8aAjTd6gsaR6Fg32s7FsllAY03O+I3Fv0rB5zMzEu+5cA27c0uh1tC5g33
	n90Ngb0l78jFX9doQn0L0XHAFsArwr5Vl0CgP8OuTu3Dr7GG+cCSx8p2KnEPfQjJKgFs8pWCf0y
	EEsRMKnezUnq4EXOqWVmbf3T3FvEM7LqSBvTjMuorqc7RUThj/2L7QQEnLlsBnm8FHmPKRdg1QY
	bJXgvM/p+ZDsb1xa1vU41fqjy+UIJttJtcudzbpYVOjLQ8SrNmyt5O6EXnCqzCXl596H4RevJSl
	3UD8PjsNzb1FBzf0wkRU+FReHIj0G9SZvt5hddHMn+2JcvqGflAe0kwjxE6i+9uqigpGla4cKnz
	4
X-Received: by 2002:aa7:da89:0:b0:661:f987:357b with SMTP id
 4fb4d7f45d1cf-66f9f1d713cmr4620a12.14.1775603174425; Tue, 07 Apr 2026
 16:06:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260406-teaming-driver-internal-v5-0-e8a3f348a1c5@google.com>
 <20260406074437.3ebb904a@kernel.org> <CANkEMg=DOiwj-ZbTLGC3oXaQuPM=sGOjg09CTXNpguCL5dh7Ug@mail.gmail.com>
In-Reply-To: <CANkEMg=DOiwj-ZbTLGC3oXaQuPM=sGOjg09CTXNpguCL5dh7Ug@mail.gmail.com>
From: Marc Harvey <marcharvey@google.com>
Date: Tue, 7 Apr 2026 16:06:02 -0700
X-Gm-Features: AQROBzD7QpyozeSBIy2mXUDVY6lrhOs36GjlEK3ZGP87OP5SUlpgMnX1Qnvt-Qg
Message-ID: <CANkEMgmeHoJkffx3B+N04buW-V0pHD9c=jajNWafmev6f6K85A@mail.gmail.com>
Subject: Re: [PATCH net-next v5 00/10] Decouple receive and transmit
 enablement in team driver
To: Jakub Kicinski <kuba@kernel.org>
Cc: Jiri Pirko <jiri@resnulli.us>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Paolo Abeni <pabeni@redhat.com>, Shuah Khan <shuah@kernel.org>, Simon Horman <horms@kernel.org>, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-276202-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[google.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[marcharvey@google.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linux.dev:url]
X-Rspamd-Queue-Id: 1A7243B5675
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, Apr 6, 2026 at 10:04=E2=80=AFPM Marc Harvey <marcharvey@google.com>=
 wrote:
>
> On Mon, Apr 6, 2026 at 7:44=E2=80=AFAM Jakub Kicinski <kuba@kernel.org> w=
rote:
> >
> > On Mon, 06 Apr 2026 03:03:36 +0000 Marc Harvey wrote:
> > > Allow independent control over receive and transmit enablement states
> > > for aggregated ports in the team driver.
> > >
> > > The motivation is that IEE 802.3ad LACP "independent control" can't
> > > be implemented for the team driver currently. This was added to the
> > > bonding driver in commit 240fd405528b ("bonding: Add independent
> > > control state machine").
> > >
> > > This series also has a few patches that add tests to show that the ol=
d
> > > coupled enablement still works and that the new decoupled enablement
> > > works as intended (4, 5, and 10).
> > >
> > > There are three patches with small fixes as well, with the goal of
> > > making the final decoupling patch clearer (1, 2, and 3).
> >
> > activebackup:
> >
> > TAP version 13
> > 1..1
> > # overriding timeout to 2400
> > # selftests: drivers/net/team: teamd_activebackup.sh
> > # Setting up two-link aggregation for runner activebackup
> > # Teamd version is: teamd 1.32
> > # Conf files are /tmp/tmp.ydjNK9Um7H and /tmp/tmp.xZuc3cWbN0
> > # This program is not intended to be run as root.
> > # This program is not intended to be run as root.
> > # Created team devices
> > # Teamd PIDs are 21457 and 21461
> > # exec of "ip link set eth0 up" failed: No such file or directory
> > # exec of "ip link set eth0 up" failed: No such file or directory
> > # exec of "ip link set eth1 up" failed: No such file or directory
> > # exec of "ip link set eth1 up" failed: No such file or directory
> > # PING fd00::2 (fd00::2) 56 data bytes
> > # 64 bytes from fd00::2: icmp_seq=3D1 ttl=3D64 time=3D0.753 ms
> > #
> > # --- fd00::2 ping statistics ---
> > # 1 packets transmitted, 1 received, 0% packet loss, time 0ms
> > # rtt min/avg/max/mdev =3D 0.753/0.753/0.753/0.000 msPacket count for t=
est_team2 was 0
> > # Waiting for eth0 in ns2-lZ0gqd to stop receiving
> > # Packet count for eth0 was 0Packet count for eth0 was 0
> > # Packet count for eth1 was 0
> > # Waiting for eth1 in ns2-lZ0gqd to stop receiving
> > # Packet count for eth1 was 0Packet count for eth0 was 0
> > # Packet count for eth1 was 0
> > # TEST: teamd active backup runner test                               [=
FAIL]
> > # Traffic did not reach team interface in NS2.
> > # Tearing down two-link aggregation
> > # Failed to kill daemon: Timer expired
> > # Failed to kill daemon: Timer expired
> > # Sending sigkill to teamd for test_team1
> > # rm: cannot remove '/var/run/teamd/test_team1.pid': No such file or di=
rectory
> > # rm: cannot remove '/var/run/teamd/test_team1.sock': No such file or d=
irectory
> > # Sending sigkill to teamd for test_team2
> > # rm: cannot remove '/var/run/teamd/test_team2.pid': No such file or di=
rectory
> > # rm: cannot remove '/var/run/teamd/test_team2.sock': No such file or d=
irectory
> > not ok 1 selftests: drivers/net/team: teamd_activebackup.sh # exit=3D1
> >
> >
> > transmit_failover:
> >
> > TAP version 13
> > 1..1
> > # overriding timeout to 2400
> > # selftests: drivers/net/team: transmit_failover.sh
> > # Error: ipv6: address not found.
> > # Setting team in ns2-yxjiUo to mode roundrobin
> > # Error: ipv6: address not found.
> > # Setting team in ns1-Jht6kA to mode broadcast
> > # Packet count for eth0 was 0
> > # Packet count for eth1 was 0
> > # Packet count for eth0 was 0
> > # Packet count for eth1 was 0
> > # Packet count for eth0 was 0
> > # Packet count for eth1 was 0
> > # TEST: Failover of 'broadcast' test                                  [=
FAIL]
> > # eth0 not transmitting when both links enabled
> > # Setting team in ns1-Jht6kA to mode roundrobin
> > # Packet count for eth0 was 0
> > # Packet count for eth1 was 0
> > # Packet count for eth0 was 0
> > # Packet count for eth1 was 0
> > # Packet count for eth0 was 0
> > # Packet count for eth1 was 0
> > # TEST: Failover of 'roundrobin' test                                 [=
FAIL]
> > # eth0 not transmitting when both links enabled
> > # Setting team in ns1-Jht6kA to mode random
> > # Packet count for eth0 was 0
> > # Packet count for eth1 was 0
> > # Packet count for eth0 was 0
> > # Packet count for eth1 was 0
> > # Packet count for eth0 was 0
> > # Packet count for eth1 was 0
> > # TEST: Failover of 'random' test                                     [=
FAIL]
> > # eth0 not transmitting when both links enabled
> > not ok 1 selftests: drivers/net/team: transmit_failover.sh # exit=3D1
> > --
> > pw-bot: cr
>
> Apologies for all of the test failures. Before sending this revision,
> I ran each test thousands of times and observed no failures, so I
> thought the flakiness would be resolved.
>
> No matter what I try, I can't recreate either issue on my end. I've
> tried building with the exact config from one of the test runs
> (https://netdev-ctrl.bots.linux.dev/logs/vmksft/bonding/results/590921/).
> I've tried stressing the VM according to
> https://github.com/linux-netdev/nipa/wiki/How-to-run-netdev-selftests-CI-=
style#reproducing-unstable-tests
> (this makes the tests time out, but I can still see traffic). I've
> tried using the netdev-testing/net-next-2026-04-06--09-00 kernel
> source. I've tried in nested and unnested virtual machines. I've also
> tried running multiple test instances in parallel, but nothing
> recreates the issues. The issues seem related to tcpdump, but without
> reproducing them, I can only guess. Any suggestions for running the
> tests exactly as the CI does would be greatly appreciated.
>
> - Marc

Thank you very much to kuniyu@google.com, who figured out how to
recreate the issue on Fedora. Fedora's /etc/services maps TCP port
1234 to the "search-agent" service (normal), which tcpdump then uses
to text-replace port numbers in its output. So the tests were looking
for ${ip_address}.1234, but tcpdump was spitting out
${ip_address}.search_agent. What is strange is that the test already
uses tcpdump's "-n" option: "Don't convert addresses (i.e., host
addresses, port numbers, etc.) to names."

It turns out that Fedora has a patched version of tcpdump that
separates the normal "-n" option into two options! "-n" handles host
addresses, and "-nn" handles port and protocol numbers. The tcpdump
invocation used by the selftests only uses "-n". What's stranger is
that passing "-nn" to tcpdump is actually portable, because under the
hood it is treated as a counter, with or without the Fedora patch:
https://github.com/the-tcpdump-group/tcpdump/blob/master/tcpdump.c#L1915
(thanks again to Kuniyuki for discovering this).

For v6, I will just change the TCP port to one that is not used by a
service, and will make the tcpdump helper function in the
net/forwarding lib use "-nn" instead of "-n".

- Marc

