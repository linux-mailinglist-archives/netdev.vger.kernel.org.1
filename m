Return-Path: <netdev+bounces-305879-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 9WWfIDt3Tmo7NQIAu9opvQ
	(envelope-from <netdev+bounces-305879-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 08 Jul 2026 18:13:47 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C45D972885F
	for <lists+netdev@lfdr.de>; Wed, 08 Jul 2026 18:13:46 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b="jO/J01/h";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-305879-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-305879-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 7B0423026F3B
	for <lists+netdev@lfdr.de>; Wed,  8 Jul 2026 15:51:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 608A93F12C8;
	Wed,  8 Jul 2026 15:51:01 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 062B93AA4F9;
	Wed,  8 Jul 2026 15:50:59 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783525861; cv=none; b=PHIH2X8Oz3+NNnnYevf7BjiTkCpXzJX2JNAeaBnMLiwlCvfHBonIswmmZ3khNw1ayTJHh0QOeQTCJ0vMbie0V3bROmMmCFueq9j7l6JpZKDGwzcV8TKB5mX3rTGXDsJa+4ch+XwV3KH568Nxtdj313BXwi0er6fZzl2VXcDwGjg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783525861; c=relaxed/simple;
	bh=0Ht6C/KQ2or/qv8egh8SNjkXW35Xwst2cMLczdpAYRY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tLGf5hNSj3UP6V10DhGEHvUpRSKk5stXiXSyL/TJV9NOtchriD23hXSLjjQGAU3tg3R7KEkxFZD6mJgxG00PO9i7Jwn7j9Xd4nDx237tLKt089/N/wdDsmNg/zGCYWs3iTQ9GgQXyLe71N7iDXCsXoW55P0HUmXnR5DrRgO/OJg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jO/J01/h; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 233CB1F000E9;
	Wed,  8 Jul 2026 15:50:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783525859;
	bh=wuE75PEjauhhf61SUJFf1x8vbYIkv9QeYpA6RcVrlJ0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=jO/J01/hzPgDT+IIB/ZBrBSWfAZUBVVJ2Xu808zgNS7EvizWJ14TTM1ia5h3h9mNi
	 Uy2SIdVH3/7cm59qm3nctebNdOYpO7zo2Xa1hTAQKYpdiLtO9dZfHdGUO4mXhbV7YA
	 FhcCeij3xyLs2HYULlUPEHJCUXRmU0NmXu1Exe5lkclxtQMdGZ3H0AVf2uFMS1k5Ct
	 bkFu+211+TSp3ZW+A3pqJcB9wErXZlCjqrVlb1xrvSoKJ/+tP+Hu67egavZjR4zNXg
	 6pOfX9cdZ1Y/+6eRAvIwHJHMMnN4YWPJYvYPiJ8LcPiIGq+LhmzLNIveEcwGos30Oy
	 yPtdC9VYsVs3g==
Message-ID: <f398373e-2cb4-4649-a491-9763df94d98b@kernel.org>
Date: Wed, 8 Jul 2026 17:50:53 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH net-next v11 7/7] selftests: netconsole: validate target
 resume
Content-Language: fr
To: Andre Carvalho <asantostc@gmail.com>, Breno Leitao <leitao@debian.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Shuah Khan <shuah@kernel.org>, Simon Horman <horms@kernel.org>
References: <20260118-netcons-retrigger-v11-0-4de36aebcf48@gmail.com>
 <20260118-netcons-retrigger-v11-7-4de36aebcf48@gmail.com>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <20260118-netcons-retrigger-v11-7-4de36aebcf48@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-305879-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[gmail.com,debian.org];
	RCPT_COUNT_TWELVE(0.00)[12];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:asantostc@gmail.com,m:leitao@debian.org,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-kselftest@vger.kernel.org,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:shuah@kernel.org,m:horms@kernel.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	HAS_ORG_HEADER(0.00)[];
	FORGED_SENDER(0.00)[matttbe@kernel.org,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[matttbe@kernel.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,vger.kernel.org:from_smtp,netcons_resume.sh:url]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: C45D972885F

Hi Andre, Breno,

On 18/01/2026 12:00, Andre Carvalho wrote:
> Introduce a new netconsole selftest to validate that netconsole is able
> to resume a deactivated target when the low level interface comes back.
> 
> The test setups the network using netdevsim, creates a netconsole target
> and then remove/add netdevsim in order to bring the same interfaces
> back. Afterwards, the test validates that the target works as expected.
> 
> Targets are created via cmdline parameters to the module to ensure that
> we are able to resume targets that were bound by mac and interface name.

I'm sorry to react on this "old" patch, but I have some troubles running
this netcons_resume.sh test in a new environment with containers.

> diff --git a/tools/testing/selftests/drivers/net/netcons_resume.sh b/tools/testing/selftests/drivers/net/netcons_resume.sh
> new file mode 100755
> index 000000000000..fc5e5e3ad3d4
> --- /dev/null
> +++ b/tools/testing/selftests/drivers/net/netcons_resume.sh

(...)

> +function trigger_reactivation() {
> +	# Add back low level module
> +	modprobe netdevsim
> +	# Recreate namespace and two interfaces
> +	set_network
> +	# Restore MACs
> +	ip netns exec "${NAMESPACE}" ip link set "${DSTIF}" \
> +		address "${SAVED_DSTMAC}"
> +	if [ "${BINDMODE}" == "mac" ]; then
> +		ip link set dev "${SRCIF}" down
> +		ip link set dev "${SRCIF}" address "${SAVED_SRCMAC}"
> +		# Rename device in order to trigger target resume, as initial
> +		# when device was recreated it didn't have correct mac address.
> +		ip link set dev "${SRCIF}" name "${TARGET}"

When I execute the test, the "ifname" bind mode works without issues,
but the "mac" one not. From what I see, the socat process doesn't get
any UDP packet when expected. I wonder if the problem might not come
from here: the interface is disabled before changing the MAC address and
renaming the interface, but not re-enabled at the end. Is it normal?

If I add 'up' at the end of this last line here, or if I remove the
whole if-statement block, the test passes.

In the console, I can see these messages, with or without re-enabling
the interface:

  netdevsim netdevsim642 eni642np1: renamed from eth0
  netdevsim netdevsim387 eni387np1: renamed from eth1
  netconsole: netconsole: local port 1514
  netconsole: netconsole: local IPv4 address 192.0.2.1
  netconsole: netconsole: interface name ''
  netconsole: netconsole: local ethernet address '1e:95:b7:ae:ab:dc'
  netconsole: netconsole: remote port 6666
  netconsole: netconsole: remote IPv4 address 192.0.2.2
  netconsole: netconsole: remote ethernet address e6:12:42:f8:4c:b2
  printk: console [netcon_ext0] enabled
  netconsole: network logging started
  netconsole: network logging stopped on interface eni387np1 as it
unregistered
  netdevsim netdevsim642 eni642np1: renamed from eth0
  netdevsim netdevsim387 eni387np1: renamed from eth1
  netconsole: Process resuming  (mac: 1e:95:b7:ae:ab:dc), s:2, r:-1
  netpoll: netconsole: device 1e:95:b7:ae:ab:dc not up yet, forcing it
  netconsole: network logging resumed on interface eni387np1
  netdevsim netdevsim387 netcons_LFLQP: renamed from eni387np1
  netconsole selftest: netcons_LFLQP

The "network logging resumed on interface" seems to suggest that the
previous patch of this series here, commit 220dbe3c76ed ("netconsole:
resume previously deactivated target"), managed to resume the previously
activated target, but not in my case.

What I don't understand is why is it working on the Netdev CI, and not
on my side. The main difference is that I might be missing some
userspace packages -- but I don't see what can be missing here, all
other netconsole tests pass -- a specific kernel config, or not applied
patch. Or something different on the host -- in a container on my side
-- but there shouldn't be any interactions with the host here,
everything is happening in the VM. Any ideas? :)

> +	fi
> +}
> +
> +function trigger_deactivation() {
> +	# Start by storing mac addresses so we can be restored in reactivate
> +	SAVED_DSTMAC=$(ip netns exec "${NAMESPACE}" \
> +		cat /sys/class/net/"$DSTIF"/address)
> +	SAVED_SRCMAC=$(mac_get "${SRCIF}")
> +	# Remove low level module
> +	rmmod netdevsim
> +}
> +
> +trap cleanup EXIT
> +
> +# Run the test twice, with different cmdline parameters
> +for BINDMODE in "ifname" "mac"
> +do
> +	echo "Running with bind mode: ${BINDMODE}" >&2
> +	# Set current loglevel to KERN_INFO(6), and default to KERN_NOTICE(5)
> +	echo "6 5" > /proc/sys/kernel/printk

Can we remove this? Without that, it is hard to understand what went
wrong in case of issues.

> +
> +	# Create one namespace and two interfaces
> +	set_network
> +
> +	# Create the command line for netconsole, with the configuration from
> +	# the function above
> +	CMDLINE=$(create_cmdline_str "${BINDMODE}")
> +
> +	# The content of kmsg will be save to the following file
> +	OUTPUT_FILE="/tmp/${TARGET}-${BINDMODE}"
> +
> +	# Load the module, with the cmdline set
> +	modprobe netconsole "${CMDLINE}"
> +	# Expose cmdline target in configfs
> +	mkdir "${NETCONS_CONFIGFS}/cmdline0"
> +
> +	# Target should be enabled
> +	wait_target_state "cmdline0" "enabled"
> +
> +	# Trigger deactivation by unloading netdevsim module. Target should be
> +	# disabled.
> +	trigger_deactivation
> +	wait_target_state "cmdline0" "disabled"
> +
> +	# Trigger reactivation by loading netdevsim, recreating the network and
> +	# restoring mac addresses. Target should be re-enabled.
> +	trigger_reactivation
> +	wait_target_state "cmdline0" "enabled"
> +
> +	# Listen for netconsole port inside the namespace and destination
> +	# interface
> +	listen_port_and_save_to "${OUTPUT_FILE}" &
> +	# Wait for socat to start and listen to the port.
> +	wait_local_port_listen "${NAMESPACE}" "${PORT}" udp
> +	# Send the message
> +	echo "${MSG}: ${TARGET}" > /dev/kmsg
> +	# Wait until socat saves the file to disk
> +	busywait "${BUSYWAIT_TIMEOUT}" test -s "${OUTPUT_FILE}"

In my case, the script was stopping here, without any message. I can
send a patch adding "|| true" to go to the next instruction, and display
"FAIL: File was not generated.".

> +	# Make sure the message was received in the dst part
> +	# and exit
> +	validate_msg "${OUTPUT_FILE}"
> +
> +	# kill socat in case it is still running
> +	pkill_socat
> +	# Cleanup & unload the module
> +	cleanup
> +
> +	echo "${BINDMODE} : Test passed" >&2
> +done
> +
> +trap - EXIT
> +exit "${EXIT_STATUS}"
> 

Cheers,
Matt

