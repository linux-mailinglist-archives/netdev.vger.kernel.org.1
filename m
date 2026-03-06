Return-Path: <netdev+bounces-264940-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8HY+FM9Mq2k+cAEAu9opvQ
	(envelope-from <netdev+bounces-264940-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 06 Mar 2026 22:53:19 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A480E2281BE
	for <lists+netdev@lfdr.de>; Fri, 06 Mar 2026 22:53:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 23B0F301953F
	for <lists+netdev@lfdr.de>; Fri,  6 Mar 2026 21:53:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B069D346E7B;
	Fri,  6 Mar 2026 21:53:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Cl7fF1hV"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D7D7346E46
	for <netdev@vger.kernel.org>; Fri,  6 Mar 2026 21:53:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772833996; cv=none; b=BsHFhdAZ5vdyEY+OAwJRil+9ddspwc+yjnHgxZmkhEmo3i0nHiLa/GwbwKka8MprIeHKcUsQC8zEseDvCxEedZ/3aW8FvVPI/RyQj9g1G1w7LTvg9La20WVJzGxYAyzG+WVIbRSvhiqDgAMjlyX+RqQnWF1UCPtr7L5VEOH6trA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772833996; c=relaxed/simple;
	bh=NA+Gg0iccmw3fanRJOkgWSag1qmDVaapR8Fd1CbpRZQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TD9WLh4PdUVO46gnOaR+naWLmf8kvEkwVbUiDAS3eTQf6HB2oIL68G/ICtQFhW8KEK5QBlpAAYRqExmtkiWTBIJvPH+s9r6VZlgZAmDZJl4bNPkV5NTNdKnsonWYqSwGYIpEemYC4DMKrUWADQuQRabWLbixmEXOtBC5rl9Zidc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Cl7fF1hV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0BBCC4CEF7;
	Fri,  6 Mar 2026 21:53:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772833996;
	bh=NA+Gg0iccmw3fanRJOkgWSag1qmDVaapR8Fd1CbpRZQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Cl7fF1hVZ6C31ZpF04MBV1dn+Qnos7wax3kKczGHxgOuaV+sogUDPFjJwSZRM6s+c
	 gPKzJ6L8HdGdrkjRDTeakj8ncSiFxHqjehKVMDJC61N2zcw942+ZKwlRWEBAta8SWw
	 fKzgFsUoqw1/hmz1Km7yAhPXmqv8tl9JVn8+ceY6WDZbmRGxHu/mOTYw5MCharPyy2
	 e+fUbDC6ZpLsNBgDorme0hklCqURNJEybZpo4fY+tdArpq6ieePKp9cSQAGJOYDKzs
	 4IONnxYRKv58MNZ49d80FjmMoD0iviV7KuvLERzj/fMZ7XOIIp5CW3foxOQxPF/krd
	 4c3S4AeA/kpCA==
Date: Fri, 6 Mar 2026 13:53:14 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Wei Wang <weibunny@fb.com>
Cc: <netdev@vger.kernel.org>, Daniel Zahka <daniel.zahka@gmail.com>, Willem
 de Bruijn <willemdebruijn.kernel@gmail.com>, David Wei <dw@davidwei.uk>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>
Subject: Re: [PATCH v2 net-next 9/9] selftest/net: psp: Add test for
 dev-assoc/disassoc
Message-ID: <20260306135314.35b63df1@kernel.org>
In-Reply-To: <20260304000050.3366381-10-weibunny@fb.com>
References: <20260304000050.3366381-1-weibunny@fb.com>
	<20260304000050.3366381-10-weibunny@fb.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: A480E2281BE
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com,davidwei.uk,lunn.ch,davemloft.net,google.com];
	TAGGED_FROM(0.00)[bounces-264940-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-0.993];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[8];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,netns.name:url]
X-Rspamd-Action: no action

On Tue, 3 Mar 2026 16:00:49 -0800 Wei Wang wrote:
> +def _data_basic_send_netkit_psp_assoc(cfg, version, ipver):
> +    """
> +    Test basic data send with netkit interface associated with PSP dev.
> +    """
> +
> +    _init_psp_dev(cfg, True)
> +    psp_dev_id_for_assoc = cfg.psp_dev_id
> +
> +    # Associate PSP device with nk_guest interface (in guest namespace)
> +    nk_guest_dev = ip(f"link show dev {cfg._nk_guest_ifname}", json=True, ns=cfg.netns)[0]

dev info is one of the few things the env class should have loaded for
us. Please add it if it's missing, we have it for other envs (env.dev,
env.remote_dev, nk should presumably be env.nk_dev ? or env.cont_dev ?)

> +    nk_guest_ifindex = nk_guest_dev['ifindex']
> +
> +    cfg.pspnl.dev_assoc({'id': psp_dev_id_for_assoc, 'ifindex': nk_guest_ifindex, 'nsid': cfg.psp_dev_peer_nsid})

Please wrap lines at 80 chars.

> +    # Check if assoc-list contains nk_guest
> +    dev_info = cfg.pspnl.dev_get({'id': psp_dev_id_for_assoc})
> +
> +    if 'assoc-list' in dev_info:
> +        found = False
> +        for assoc in dev_info['assoc-list']:
> +            if assoc['ifindex'] == nk_guest_ifindex and assoc['nsid'] == cfg.psp_dev_peer_nsid:
> +                found = True
> +                break

Should it not be the _only_ assoc? Maybe let's start with that
assumption and complicate the tests later if needed?
The other tests are rotating the keys and generally assuming full
control over PSP so I don't think we should cater to the case of
"something else is using PSP on the base system" here either.

Let's also check how the attributes look from inside the netns
and how they look if the netkit and netdevsim are in the same netns?
(unless you already have that. this patch is a bit enormous :()

> +        ksft_true(found, "Associated device not found in dev_get() response")
> +    else:
> +        raise RuntimeError("No assoc-list in dev_get() response after association")

KsftFailEx() ?

> +    # Enter guest namespace (netns) to run PSP test
> +    with NetNSEnter(cfg.netns.name):
> +        cfg.pspnl = PSPFamily()
> +
> +        s = _make_psp_conn(cfg, version, ipver)
> +
> +        rx_assoc = cfg.pspnl.rx_assoc({"version": version,
> +                                       "dev-id": cfg.psp_dev_id,
> +                                       "sock-fd": s.fileno()})
> +        rx = rx_assoc['rx-key']
> +        tx = _spi_xchg(s, rx)
> +
> +        cfg.pspnl.tx_assoc({"dev-id": cfg.psp_dev_id,
> +                            "version": version,
> +                            "tx-key": tx,
> +                            "sock-fd": s.fileno()})
> +
> +        data_len = _send_careful(cfg, s, 100)
> +        _check_data_rx(cfg, data_len)
> +        _close_psp_conn(cfg, s)
> +
> +    # Clean up - back in host namespace
> +    cfg.pspnl = PSPFamily()
> +    cfg.pspnl.dev_disassoc({'id': psp_dev_id_for_assoc, 'ifindex': nk_guest_ifindex, 'nsid': cfg.psp_dev_peer_nsid})
> +
> +    del cfg.psp_dev_id
> +    del cfg.psp_info
> +
> +
> +def _key_rotation_notify_multi_ns_netkit(cfg, version, ipver):
> +    """ Test key rotation notifications across multiple namespaces using netkit """
> +    import threading

I don't think we need threading for this test.. ?
If we open a socket while in one netns and then switch the netns back
the previously opened socket should still be in the netns? So we can
just ntf_check() directly from the main thread? 

> +    _init_psp_dev(cfg, True)
> +    psp_dev_id_for_assoc = cfg.psp_dev_id
> +
> +    # Associate PSP device with nk_guest interface (in guest namespace)
> +    nk_guest_dev = ip(f"link show dev {cfg._nk_guest_ifname}", json=True, ns=cfg.netns)[0]
> +    nk_guest_ifindex = nk_guest_dev['ifindex']
> +
> +    cfg.pspnl.dev_assoc({'id': psp_dev_id_for_assoc, 'ifindex': nk_guest_ifindex, 'nsid': cfg.psp_dev_peer_nsid})
> +
> +    results = {'main_ns': None, 'peer_ns': None}
> +
> +    def listen_in_namespace(ns_name, result_key):
> +        """Listen for key rotation notifications in a namespace"""
> +        try:
> +            if ns_name:
> +                ctx = NetNSEnter(ns_name)
> +            else:
> +                from contextlib import nullcontext
> +                ctx = nullcontext()
> +
> +            with ctx:
> +                pspnl = PSPFamily()
> +                pspnl.ntf_subscribe('use')
> +
> +                collected_notifications = []
> +                for i in range(100):
> +                    pspnl.check_ntf()
> +
> +                    try:
> +                        while True:
> +                            msg = pspnl.async_msg_queue.get_nowait()
> +                            collected_notifications.append(msg['msg'])
> +                    except:
> +                        pass
> +
> +                    if collected_notifications:
> +                        results[result_key] = collected_notifications
> +                        break
> +
> +                    time.sleep(0.1)
> +                else:
> +                    # Timeout - no notification received
> +                    results[result_key] = []
> +        except Exception as e:
> +            results[result_key] = {'error': str(e)}
> +
> +    # Create listener threads
> +    # Main namespace listener
> +    main_ns_thread = threading.Thread(
> +        target=listen_in_namespace,
> +        args=(None, 'main_ns'),
> +        name='main_ns_listener'
> +    )
> +    # Guest namespace listener (netkit peer)
> +    guest_ns_thread = threading.Thread(
> +        target=listen_in_namespace,
> +        args=(cfg.netns.name, 'peer_ns'),
> +        name='guest_ns_listener'
> +    )
> +
> +    main_ns_thread.start()
> +    guest_ns_thread.start()
> +
> +    time.sleep(0.5)
> +
> +    # Trigger key rotation on the PSP device
> +    cfg.pspnl.key_rotate({"id": psp_dev_id_for_assoc})
> +
> +    main_ns_thread.join(timeout=15)
> +    guest_ns_thread.join(timeout=15)
> +
> +    # Verify notifications were received in both namespaces
> +    ksft_not_none(results['main_ns'], "No result from main namespace listener")
> +    ksft_not_none(results['peer_ns'], "No result from guest namespace listener")
> +
> +    # Check for errors in listeners
> +    if isinstance(results['main_ns'], dict) and 'error' in results['main_ns']:
> +        raise RuntimeError(f"Main NS listener error: {results['main_ns']['error']}")
> +    if isinstance(results['peer_ns'], dict) and 'error' in results['peer_ns']:
> +        raise RuntimeError(f"Guest NS listener error: {results['peer_ns']['error']}")
> +
> +    # Verify that both namespaces received at least one notification
> +    ksft_gt(len(results['main_ns']), 0, "No key rotation notification received in main namespace")
> +    ksft_gt(len(results['peer_ns']), 0, "No key rotation notification received in guest namespace")
> +
> +    # Verify the notification contains the expected dev_id
> +    main_ns_has_dev = any(
> +        ntf.get('id') == psp_dev_id_for_assoc
> +        for ntf in results['main_ns']
> +    )
> +    guest_ns_has_dev = any(
> +        ntf.get('id') == psp_dev_id_for_assoc
> +        for ntf in results['peer_ns']
> +    )
> +
> +    ksft_true(main_ns_has_dev, "Key rotation notification for correct device not found in main namespace")
> +    ksft_true(guest_ns_has_dev, "Key rotation notification for correct device not found in guest namespace")
> +
> +    # Clean up
> +    cfg.pspnl.dev_disassoc({'id': psp_dev_id_for_assoc, 'ifindex': nk_guest_ifindex, 'nsid': cfg.psp_dev_peer_nsid})
> +    del cfg.psp_dev_id
> +    del cfg.psp_info
> +
> +
> +def _dev_change_notify_multi_ns_netkit(cfg, version, ipver):
> +    """ Test dev_change notifications across multiple namespaces using netkit """
> +    import threading
> +
> +    _init_psp_dev(cfg, True)
> +    psp_dev_id_for_assoc = cfg.psp_dev_id
> +
> +    # Associate PSP device with nk_guest interface (in guest namespace)
> +    nk_guest_dev = ip(f"link show dev {cfg._nk_guest_ifname}", json=True, ns=cfg.netns)[0]
> +    nk_guest_ifindex = nk_guest_dev['ifindex']
> +
> +    cfg.pspnl.dev_assoc({'id': psp_dev_id_for_assoc, 'ifindex': nk_guest_ifindex, 'nsid': cfg.psp_dev_peer_nsid})
> +
> +    results = {'main_ns': None, 'peer_ns': None}
> +
> +    def listen_in_namespace(ns_name, result_key):
> +        """Listen for dev_change notifications in a namespace"""
> +        try:
> +            if ns_name:
> +                ctx = NetNSEnter(ns_name)
> +            else:
> +                from contextlib import nullcontext
> +                ctx = nullcontext()
> +
> +            with ctx:
> +                pspnl = PSPFamily()
> +                pspnl.ntf_subscribe('mgmt')
> +
> +                collected_notifications = []
> +                for i in range(100):
> +                    pspnl.check_ntf()
> +
> +                    try:
> +                        while True:
> +                            msg = pspnl.async_msg_queue.get_nowait()
> +                            collected_notifications.append(msg['msg'])
> +                    except:
> +                        pass
> +
> +                    if collected_notifications:
> +                        results[result_key] = collected_notifications
> +                        break
> +
> +                    time.sleep(0.1)
> +                else:
> +                    # Timeout - no notification received
> +                    results[result_key] = []
> +        except Exception as e:
> +            results[result_key] = {'error': str(e)}
> +
> +    # Create listener threads
> +    # Main namespace listener
> +    main_ns_thread = threading.Thread(
> +        target=listen_in_namespace,
> +        args=(None, 'main_ns'),
> +        name='main_ns_listener'
> +    )
> +    # Guest namespace listener (netkit peer)
> +    guest_ns_thread = threading.Thread(
> +        target=listen_in_namespace,
> +        args=(cfg.netns.name, 'peer_ns'),
> +        name='guest_ns_listener'
> +    )
> +
> +    main_ns_thread.start()
> +    guest_ns_thread.start()
> +
> +    time.sleep(1.0)  # Give threads time to subscribe
> +
> +    # Trigger dev_change by calling dev_set (notification is always sent)
> +    cfg.pspnl.dev_set({'id': psp_dev_id_for_assoc, 'psp-versions-ena': cfg.psp_info['psp-versions-cap']})
> +
> +    main_ns_thread.join(timeout=15)
> +    guest_ns_thread.join(timeout=15)
> +
> +    # Verify notifications were received in both namespaces
> +    ksft_not_none(results['main_ns'], "No result from main namespace listener")
> +    ksft_not_none(results['peer_ns'], "No result from guest namespace listener")
> +
> +    # Check for errors in listeners
> +    if isinstance(results['main_ns'], dict) and 'error' in results['main_ns']:
> +        raise RuntimeError(f"Main NS listener error: {results['main_ns']['error']}")
> +    if isinstance(results['peer_ns'], dict) and 'error' in results['peer_ns']:
> +        raise RuntimeError(f"Guest NS listener error: {results['peer_ns']['error']}")
> +
> +    # Verify that both namespaces received at least one notification
> +    ksft_gt(len(results['main_ns']), 0, "No dev_change notification received in main namespace")
> +    ksft_gt(len(results['peer_ns']), 0, "No dev_change notification received in guest namespace")
> +
> +    # Verify the notification contains the expected dev_id
> +    main_ns_has_dev = any(
> +        ntf.get('id') == psp_dev_id_for_assoc
> +        for ntf in results['main_ns']
> +    )
> +    guest_ns_has_dev = any(
> +        ntf.get('id') == psp_dev_id_for_assoc
> +        for ntf in results['peer_ns']
> +    )
> +
> +    ksft_true(main_ns_has_dev, "Dev_change notification for correct device not found in main namespace")
> +    ksft_true(guest_ns_has_dev, "Dev_change notification for correct device not found in guest namespace")
> +
> +    # Clean up
> +    cfg.pspnl.dev_disassoc({'id': psp_dev_id_for_assoc, 'ifindex': nk_guest_ifindex, 'nsid': cfg.psp_dev_peer_nsid})
> +    del cfg.psp_dev_id
> +    del cfg.psp_info
> +
> +
> +def _psp_dev_get_check_netkit_psp_assoc(cfg, version, ipver):
> +    """ Check psp dev-get output with netkit interface associated with PSP dev """
> +
> +    _init_psp_dev(cfg, True)
> +    psp_dev_id_for_assoc = cfg.psp_dev_id
> +
> +    # Associate PSP device with nk_guest interface (in guest namespace)
> +    nk_guest_dev = ip(f"link show dev {cfg._nk_guest_ifname}", json=True, ns=cfg.netns)[0]
> +    nk_guest_ifindex = nk_guest_dev['ifindex']
> +
> +    cfg.pspnl.dev_assoc({'id': psp_dev_id_for_assoc, 'ifindex': nk_guest_ifindex, 'nsid': cfg.psp_dev_peer_nsid})
> +
> +    # Check 1: In default netns, verify dev-get has correct ifindex and assoc-list
> +    dev_info = cfg.pspnl.dev_get({'id': psp_dev_id_for_assoc})
> +
> +    # Verify the PSP device has the correct ifindex
> +    ksft_eq(dev_info['ifindex'], cfg.psp_ifindex)
> +
> +    # Verify assoc-list exists and contains the associated nk_guest with correct ifindex and nsid
> +    ksft_true('assoc-list' in dev_info, "No assoc-list in dev_get() response after association")
> +    found = False
> +    for assoc in dev_info['assoc-list']:
> +        if assoc['ifindex'] == nk_guest_ifindex and assoc['nsid'] == cfg.psp_dev_peer_nsid:
> +            found = True
> +            break
> +    ksft_true(found, "Associated device not found in assoc-list with correct ifindex and nsid")
> +
> +    # Check 2: In guest netns, verify dev-get has assoc-list with nk_guest device
> +    with NetNSEnter(cfg.netns.name):
> +        peer_pspnl = PSPFamily()
> +
> +        # Dump all devices in the guest namespace
> +        peer_devices = peer_pspnl.dev_get({}, dump=True)
> +
> +        # Find the device with by-association flag
> +        peer_dev = None
> +        for dev in peer_devices:
> +            if dev.get('by-association'):
> +                peer_dev = dev
> +                break
> +
> +        ksft_not_none(peer_dev, "No PSP device found with by-association flag in guest netns")
> +
> +        # Verify assoc-list contains the nk_guest device
> +        ksft_true('assoc-list' in peer_dev and len(peer_dev['assoc-list']) > 0,
> +                  "Guest device should have assoc-list with local devices")
> +
> +        # Verify the assoc-list contains nk_guest ifindex with nsid=-1 (same namespace)
> +        found = False
> +        for assoc in peer_dev['assoc-list']:
> +            if assoc['ifindex'] == nk_guest_ifindex:
> +                ksft_eq(assoc['nsid'], -1,
> +                        "nsid should be -1 (NETNSA_NSID_NOT_ASSIGNED) for same-namespace device")
> +                found = True
> +                break
> +        ksft_true(found, "nk_guest ifindex not found in assoc-list")
> +
> +    # Clean up
> +    cfg.pspnl.dev_disassoc({'id': psp_dev_id_for_assoc, 'ifindex': nk_guest_ifindex, 'nsid': cfg.psp_dev_peer_nsid})
> +
> +    del cfg.psp_dev_id
> +    del cfg.psp_info
> +
> +
> +def _psp_dev_assoc_cleanup_on_netkit_del(cfg):
> +    """ Test that assoc-list is cleared when associated netkit interface is deleted """
> +    import subprocess

use cmd()?  feels like this code is AI generated
please review it carefully before repost

