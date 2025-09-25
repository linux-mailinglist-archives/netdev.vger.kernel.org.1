Return-Path: <netdev+bounces-226198-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 90D94B9DDB3
	for <lists+netdev@lfdr.de>; Thu, 25 Sep 2025 09:30:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4559B4C05D7
	for <lists+netdev@lfdr.de>; Thu, 25 Sep 2025 07:30:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2EC42E8B9B;
	Thu, 25 Sep 2025 07:30:02 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpbgjp3.qq.com (smtpbgjp3.qq.com [54.92.39.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD68F2E8DFF
	for <netdev@vger.kernel.org>; Thu, 25 Sep 2025 07:29:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.92.39.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758785402; cv=none; b=WkGLOoqARrXwliAvcVdSA4+yyXkO55r/Asp+kS8Mp5+R9KZvFnQGvCuly0phHO+eWuHallItvywsHYCTEGVxOm2BSEJmtLZxepDiqnryHCaU+yR1Fv2kz3+IQ0gd7Teqk+Cr3VLGA/DGUFLERkyf2/5a+efC+Ta15oQvGdvfUEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758785402; c=relaxed/simple;
	bh=uYf9N0dR8rF5Jfy0Kv8pRy2KhNel7iAWFR/gkckhUx0=;
	h=From:To:Cc:References:In-Reply-To:Subject:Date:Message-ID:
	 MIME-Version:Content-Type; b=qOlzP6FoK5F5o/KSX5V4XTBAxTnVGyt/YnGgE4dZmwYgczehjPy2MzjEOKdEpy7bGOYt7TWpl3U6N3XQEql1RijDjmhA0BpUalrv1jy7Sd+Iq/kBtzzz6bjQbVCW+QzPHLInhgDMVX6CbsIefU9IbHgKajYeoyjhgp5tMnHo4q0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com; spf=pass smtp.mailfrom=trustnetic.com; arc=none smtp.client-ip=54.92.39.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trustnetic.com
X-QQ-mid:Yeas5t1758785292t884t58962
Received: from 3DB253DBDE8942B29385B9DFB0B7E889 (jiawenwu@trustnetic.com [115.220.236.115])
X-QQ-SSF:0000000000000000000000000000000
From: =?utf-8?b?Smlhd2VuIFd1?= <jiawenwu@trustnetic.com>
X-BIZMAIL-ID: 14018371850756871639
To: "'Jakub Kicinski'" <kuba@kernel.org>
Cc: <netdev@vger.kernel.org>,
	"'Andrew Lunn'" <andrew+netdev@lunn.ch>,
	"'David S. Miller'" <davem@davemloft.net>,
	"'Eric Dumazet'" <edumazet@google.com>,
	"'Paolo Abeni'" <pabeni@redhat.com>,
	"'Simon Horman'" <horms@kernel.org>,
	"'Alexander Lobakin'" <aleksander.lobakin@intel.com>,
	"'Mengyuan Lou'" <mengyuanlou@net-swift.com>
References: <20250922094327.26092-1-jiawenwu@trustnetic.com> <20250924183640.62a1293e@kernel.org>
In-Reply-To: <20250924183640.62a1293e@kernel.org>
Subject: RE: [PATCH net-next v5 0/4] net: wangxun: support to configure RSS
Date: Thu, 25 Sep 2025 15:28:11 +0800
Message-ID: <05ab01dc2ded$f2e9a610$d8bcf230$@trustnetic.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQHTHj73TMmcD+HtktVQlPcEqyyH7gJ+IGKqtKGr+wA=
Content-Language: zh-cn
X-QQ-SENDSIZE: 520
Feedback-ID: Yeas:trustnetic.com:qybglogicsvrgz:qybglogicsvrgz6b-0
X-QQ-XMAILINFO: MPAlP4yRn0xgA4HzXXpxXTuNwEf0ALo+1ZBqe8nEMq5CX8j5fLRCd1Qv
	e1K947iQ6jESjCVLEC7n+YdbEfbqhIrrl5p8Irb+lhZ3vuzbNZoZuC8tJGpCvDyKRp6Gt+h
	XLbIx3bVtGDQxI1UN5QLbUfouTHzvu8u9yqksIGGTeVYa32rGp8N99E84/8Wp2cDAlHzwsm
	JqU7qXQg7KstR33gDGO3WzpAo4pvGQ8RkJmN/aQNbxCTuHP9Sm/yITs8gGzUBFPfme7GMbu
	PxUVaqckbilwKoQznXalwvLM0pcDaw+zX5Y21/cfeLMWUhY3Rn5wqAFp4REXNJ+2XLidvld
	jT/5hZWEviMuN0HPHP7qm7EU6vAx2sSWT2S2BwIX6ANBefdtLYxs/ydmsIVvz+8BSlY65cz
	7RkXJ4a6s0cyq3JLJejJKUC8a4HkMLB0KIUC+qupPGdLVHnIk2I4JEC6I3rYji+5PR8WIj1
	9nqql8J1tZkFM2W53rIQg+NCV1iFwDtZRAKliJ1inA5oDCkXjKrcqeXOo002d/6I+5FncMk
	bD7198/1EtVnTe5GhWNrTnR+wCSfKq5m3QsA1QwnbsMBWgubBBjuS+k6GxHOcdE7jxXr3gh
	ab5Q+1ETSSSpEQTNvwbDW4EqfpfuSt0b4cTysdcd3ngHpUzfXAZDHKlnrTOWMYnnUizCES+
	fgG0PVHl2SG5+XkR518TQOA9As/cH28TOIyhqP4u3BifknDHU8EDTFkyA7kKfs+wqXSbAxx
	JwjoqXp/YozNrEMdf0jT+8pQFaTTcmu4oX0Njgi7Potb0HlAKYasRH6ckaykdWwol4omPJn
	y5hNF8xOUUxEkjSeA+ioOhJO1BzckbkGRtte7OTMJDsua3jWPCjaSnBCYu8q3t+NzW44ASV
	sM6fKR9yEJ+w9nDvqAHYaz4jBhxoe0X74ncsBU2lRghXzp+neD/8ULSfJwYHd3O2BzWxhJT
	PS7dKNwCBXmEYn6yHOIL1dIrVfH3N7sOzs9hYiVMuVO7vDCvQJIZPjSkz8wHyEeJjutvKR1
	2K7v9bAvv7pV4yzrM2hm34hHz1V7v9bYFeHeNJmZoNfz3m336sDvIp3F1bwys=
X-QQ-XMRINFO: Mp0Kj//9VHAxr69bL5MkOOs=
X-QQ-RECHKSPAM: 0

On Thu, Sep 25, 2025 9:37 AM, Jakub Kicinski wrote:
> On Mon, 22 Sep 2025 17:43:23 +0800 Jiawen Wu wrote:
> > Implement ethtool ops for RSS configuration, and support multiple RSS
> > for multiple pools.
> 
> There is a few tests for the RSS API in the tree:
> 
> tools/testing/selftests/drivers/net/hw/rss_api.py
> tools/testing/selftests/drivers/net/hw/rss_ctx.py
> 
> Please run these and add the output to the cover letter.
> 
> Instructions for running the tests are here:
> 
> https://github.com/linux-netdev/nipa/wiki/Running-driver-tests

The output shows many fail cases. Is it normal? Or is there some issue
with my environment?

root@w-MS-7E16:~/net-next# NETIF=enp17s0f0 tools/testing/selftests/drivers/net/hw/rss_api.py
TAP version 13
1..12
ok 1 rss_api.test_rxfh_nl_set_fail
ok 2 rss_api.test_rxfh_nl_set_indir
# Exception| Traceback (most recent call last):
# Exception|   File "/root/net-next/tools/testing/selftests/net/lib/py/ksft.py", line 244, in ksft_run
# Exception|     case(*args)
# Exception|     ~~~~^^^^^^^
# Exception|   File "/root/net-next/tools/testing/selftests/drivers/net/hw/rss_api.py", line 125, in test_rxfh_nl_set_indir_ctx
# Exception|     ctx_id = _ethtool_create(cfg, "-X", "context new")
# Exception|   File "/root/net-next/tools/testing/selftests/drivers/net/hw/rss_api.py", line 26, in _ethtool_create
# Exception|     output = ethtool(f"{act} {cfg.ifname} {opts}").stdout
# Exception|              ~~~~~~~^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
# Exception|   File "/root/net-next/tools/testing/selftests/net/lib/py/utils.py", line 194, in ethtool
# Exception|     return tool('ethtool', args, json=json, ns=ns, host=host)
# Exception|   File "/root/net-next/tools/testing/selftests/net/lib/py/utils.py", line 177, in tool
# Exception|     cmd_obj = cmd(cmd_str, ns=ns, host=host)
# Exception|   File "/root/net-next/tools/testing/selftests/net/lib/py/utils.py", line 75, in __init__
# Exception|     self.process(terminate=False, fail=fail, timeout=timeout)
# Exception|     ~~~~~~~~~~~~^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
# Exception|   File "/root/net-next/tools/testing/selftests/net/lib/py/utils.py", line 95, in process
# Exception|     raise CmdExitFailure("Command failed: %s\nSTDOUT: %s\nSTDERR: %s" %
# Exception|                          (self.proc.args, stdout, stderr), self)
# Exception| net.lib.py.utils.CmdExitFailure: Command failed: ['ethtool', '-X', 'enp17s0f0', 'context', 'new']
# Exception| STDOUT: b''
# Exception| STDERR: b'Cannot set RX flow hash configuration: Operation not supported\n'
not ok 3 rss_api.test_rxfh_nl_set_indir_ctx
ok 4 rss_api.test_rxfh_indir_ntf
# Exception| Traceback (most recent call last):
# Exception|   File "/root/net-next/tools/testing/selftests/net/lib/py/ksft.py", line 244, in ksft_run
# Exception|     case(*args)
# Exception|     ~~~~^^^^^^^
# Exception|   File "/root/net-next/tools/testing/selftests/drivers/net/hw/rss_api.py", line 188, in test_rxfh_indir_ctx_ntf
# Exception|     ctx_id = _ethtool_create(cfg, "-X", "context new")
# Exception|   File "/root/net-next/tools/testing/selftests/drivers/net/hw/rss_api.py", line 26, in _ethtool_create
# Exception|     output = ethtool(f"{act} {cfg.ifname} {opts}").stdout
# Exception|              ~~~~~~~^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
# Exception|   File "/root/net-next/tools/testing/selftests/net/lib/py/utils.py", line 194, in ethtool
# Exception|     return tool('ethtool', args, json=json, ns=ns, host=host)
# Exception|   File "/root/net-next/tools/testing/selftests/net/lib/py/utils.py", line 177, in tool
# Exception|     cmd_obj = cmd(cmd_str, ns=ns, host=host)
# Exception|   File "/root/net-next/tools/testing/selftests/net/lib/py/utils.py", line 75, in __init__
# Exception|     self.process(terminate=False, fail=fail, timeout=timeout)
# Exception|     ~~~~~~~~~~~~^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
# Exception|   File "/root/net-next/tools/testing/selftests/net/lib/py/utils.py", line 95, in process
# Exception|     raise CmdExitFailure("Command failed: %s\nSTDOUT: %s\nSTDERR: %s" %
# Exception|                          (self.proc.args, stdout, stderr), self)
# Exception| net.lib.py.utils.CmdExitFailure: Command failed: ['ethtool', '-X', 'enp17s0f0', 'context', 'new']
# Exception| STDOUT: b''
# Exception| STDERR: b'Cannot set RX flow hash configuration: Operation not supported\n'
not ok 5 rss_api.test_rxfh_indir_ctx_ntf
ok 6 rss_api.test_rxfh_nl_set_key
ok 7 rss_api.test_rxfh_fields
# Exception| Traceback (most recent call last):
# Exception|   File "/root/net-next/tools/testing/selftests/net/lib/py/ksft.py", line 244, in ksft_run
# Exception|     case(*args)
# Exception|     ~~~~^^^^^^^
# Exception|   File "/root/net-next/tools/testing/selftests/drivers/net/hw/rss_api.py", line 306, in test_rxfh_fields_set
# Exception|     cfg.ethnl.rss_set({
# Exception|     ~~~~~~~~~~~~~~~~~^^
# Exception|         "header": {"dev-index": cfg.ifindex},
# Exception|         ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
# Exception|         "flow-hash": {x: change for x in flow_types}
# Exception|         ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
# Exception|     })
# Exception|     ^^
# Exception|   File "/root/net-next/tools/net/ynl/pyynl/lib/ynl.py", line 1141, in _op
# Exception|     return self._ops(ops)[0]
# Exception|            ~~~~~~~~~^^^^^
# Exception|   File "/root/net-next/tools/net/ynl/pyynl/lib/ynl.py", line 1097, in _ops
# Exception|     raise NlError(nl_msg)
# Exception| net.ynl.pyynl.lib.ynl.NlError: Netlink error: Invalid argument
# Exception| nl_len = 36 (20) nl_flags = 0x100 nl_type = 2
# Exception|    error: -22
not ok 8 rss_api.test_rxfh_fields_set
# Exception| Traceback (most recent call last):
# Exception|   File "/root/net-next/tools/testing/selftests/net/lib/py/ksft.py", line 244, in ksft_run
# Exception|     case(*args)
# Exception|     ~~~~^^^^^^^
# Exception|   File "/root/net-next/tools/testing/selftests/drivers/net/hw/rss_api.py", line 337, in test_rxfh_fields_set_xfrm
# Exception|     set_rss(cfg, {}, {"tcp4": {"ip-src"}})
# Exception|     ~~~~~~~^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
# Exception|   File "/root/net-next/tools/testing/selftests/drivers/net/hw/rss_api.py", line 321, in set_rss
# Exception|     cfg.ethnl.rss_set({"header": {"dev-index": cfg.ifindex},
# Exception|     ~~~~~~~~~~~~~~~~~^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
# Exception|                        "input-xfrm": xfrm, "flow-hash": fh})
# Exception|                        ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
# Exception|   File "/root/net-next/tools/net/ynl/pyynl/lib/ynl.py", line 1141, in _op
# Exception|     return self._ops(ops)[0]
# Exception|            ~~~~~~~~~^^^^^
# Exception|   File "/root/net-next/tools/net/ynl/pyynl/lib/ynl.py", line 1097, in _ops
# Exception|     raise NlError(nl_msg)
# Exception| net.ynl.pyynl.lib.ynl.NlError: Netlink error: Invalid argument
# Exception| nl_len = 36 (20) nl_flags = 0x100 nl_type = 2
# Exception|    error: -22
not ok 9 rss_api.test_rxfh_fields_set_xfrm
ok 10 rss_api.test_rxfh_fields_ntf
# Exception| Traceback (most recent call last):
# Exception|   File "/root/net-next/tools/testing/selftests/net/lib/py/ksft.py", line 244, in ksft_run
# Exception|     case(*args)
# Exception|     ~~~~^^^^^^^
# Exception|   File "/root/net-next/tools/testing/selftests/drivers/net/hw/rss_api.py", line 400, in test_rss_ctx_add
# Exception|     ctx = cfg.ethnl.rss_create_act({"header": {"dev-index": cfg.ifindex}})
# Exception|   File "/root/net-next/tools/net/ynl/pyynl/lib/ynl.py", line 1141, in _op
# Exception|     return self._ops(ops)[0]
# Exception|            ~~~~~~~~~^^^^^
# Exception|   File "/root/net-next/tools/net/ynl/pyynl/lib/ynl.py", line 1097, in _ops
# Exception|     raise NlError(nl_msg)
# Exception| net.ynl.pyynl.lib.ynl.NlError: Netlink error: Operation not supported
# Exception| nl_len = 36 (20) nl_flags = 0x100 nl_type = 2
# Exception|    error: -95
not ok 11 rss_api.test_rss_ctx_add
# Exception| Traceback (most recent call last):
# Exception|   File "/root/net-next/tools/testing/selftests/net/lib/py/ksft.py", line 244, in ksft_run
# Exception|     case(*args)
# Exception|     ~~~~^^^^^^^
# Exception|   File "/root/net-next/tools/testing/selftests/drivers/net/hw/rss_api.py", line 435, in test_rss_ctx_ntf
# Exception|     ctx = cfg.ethnl.rss_create_act({"header": {"dev-index": cfg.ifindex}})
# Exception|   File "/root/net-next/tools/net/ynl/pyynl/lib/ynl.py", line 1141, in _op
# Exception|     return self._ops(ops)[0]
# Exception|            ~~~~~~~~~^^^^^
# Exception|   File "/root/net-next/tools/net/ynl/pyynl/lib/ynl.py", line 1097, in _ops
# Exception|     raise NlError(nl_msg)
# Exception| net.ynl.pyynl.lib.ynl.NlError: Netlink error: Operation not supported
# Exception| nl_len = 36 (20) nl_flags = 0x100 nl_type = 2
# Exception|    error: -95
not ok 12 rss_api.test_rss_ctx_ntf
# Totals: pass:6 fail:6 xfail:0 xpass:0 skip:0 error:0



root@w-MS-7E16:~/net-next# NETIF=enp17s0f0 LOCAL_V4="10.10.10.1" REMOTE_V4="10.10.10.2" REMOTE_TYPE=ssh
REMOTE_ARGS="root@192.168.14.104" tools/testing/selftests/drivers/net/hw/rss_ctx.py
root@192.168.14.104's password:
TAP version 13
1..17
# Exception| Traceback (most recent call last):
# Exception|   File "/root/net-next/tools/testing/selftests/net/lib/py/ksft.py", line 244, in ksft_run
# Exception|     case(*args)
# Exception|     ~~~~^^^^^^^
# Exception|   File "/root/net-next/tools/testing/selftests/drivers/net/hw/rss_ctx.py", line 119, in test_rss_key_indir
# Exception|     qcnt = len(_get_rx_cnts(cfg))
# Exception|                ~~~~~~~~~~~~^^^^^
# Exception|   File "/root/net-next/tools/testing/selftests/drivers/net/hw/rss_ctx.py", line 74, in _get_rx_cnts
# Exception|     data = cfg.netdevnl.qstats_get({"ifindex": cfg.ifindex, "scope": ["queue"]}, dump=True)
# Exception|   File "/root/net-next/tools/net/ynl/pyynl/lib/ynl.py", line 1141, in _op
# Exception|     return self._ops(ops)[0]
# Exception|            ~~~~~~~~~^^^^^
# Exception|   File "/root/net-next/tools/net/ynl/pyynl/lib/ynl.py", line 1097, in _ops
# Exception|     raise NlError(nl_msg)
# Exception| net.ynl.pyynl.lib.ynl.NlError: Netlink error: Operation not supported
# Exception| nl_len = 28 (12) nl_flags = 0x202 nl_type = 3
# Exception|    error: -95
# Exception|    extack: {'bad-attr': '.ifindex'}
not ok 1 rss_ctx.test_rss_key_indir
ok 2 rss_ctx.test_rss_queue_reconfigure # SKIP Not enough queues for the test or qstat not supported
ok 3 rss_ctx.test_rss_resize
ok 4 rss_ctx.test_hitless_key_update # SKIP Test requires command: iperf3
# Exception| Traceback (most recent call last):
# Exception|   File "/root/net-next/tools/testing/selftests/net/lib/py/ksft.py", line 244, in ksft_run
# Exception|     case(*args)
# Exception|     ~~~~^^^^^^^
# Exception|   File "/root/net-next/tools/testing/selftests/drivers/net/hw/rss_ctx.py", line 446, in test_rss_context
# Exception|     qcnt = len(_get_rx_cnts(cfg))
# Exception|                ~~~~~~~~~~~~^^^^^
# Exception|   File "/root/net-next/tools/testing/selftests/drivers/net/hw/rss_ctx.py", line 74, in _get_rx_cnts
# Exception|     data = cfg.netdevnl.qstats_get({"ifindex": cfg.ifindex, "scope": ["queue"]}, dump=True)
# Exception|   File "/root/net-next/tools/net/ynl/pyynl/lib/ynl.py", line 1141, in _op
# Exception|     return self._ops(ops)[0]
# Exception|            ~~~~~~~~~^^^^^
# Exception|   File "/root/net-next/tools/net/ynl/pyynl/lib/ynl.py", line 1097, in _ops
# Exception|     raise NlError(nl_msg)
# Exception| net.ynl.pyynl.lib.ynl.NlError: Netlink error: Operation not supported
# Exception| nl_len = 28 (12) nl_flags = 0x202 nl_type = 3
# Exception|    error: -95
# Exception|    extack: {'bad-attr': '.ifindex'}
not ok 5 rss_ctx.test_rss_context
# Exception| Traceback (most recent call last):
# Exception|   File "/root/net-next/tools/testing/selftests/net/lib/py/ksft.py", line 244, in ksft_run
# Exception|     case(*args)
# Exception|     ~~~~^^^^^^^
# Exception|   File "/root/net-next/tools/testing/selftests/drivers/net/hw/rss_ctx.py", line 507, in test_rss_context4
# Exception|     test_rss_context(cfg, 4)
# Exception|     ~~~~~~~~~~~~~~~~^^^^^^^^
# Exception|   File "/root/net-next/tools/testing/selftests/drivers/net/hw/rss_ctx.py", line 446, in test_rss_context
# Exception|     qcnt = len(_get_rx_cnts(cfg))
# Exception|                ~~~~~~~~~~~~^^^^^
# Exception|   File "/root/net-next/tools/testing/selftests/drivers/net/hw/rss_ctx.py", line 74, in _get_rx_cnts
# Exception|     data = cfg.netdevnl.qstats_get({"ifindex": cfg.ifindex, "scope": ["queue"]}, dump=True)
# Exception|   File "/root/net-next/tools/net/ynl/pyynl/lib/ynl.py", line 1141, in _op
# Exception|     return self._ops(ops)[0]
# Exception|            ~~~~~~~~~^^^^^
# Exception|   File "/root/net-next/tools/net/ynl/pyynl/lib/ynl.py", line 1097, in _ops
# Exception|     raise NlError(nl_msg)
# Exception| net.ynl.pyynl.lib.ynl.NlError: Netlink error: Operation not supported
# Exception| nl_len = 28 (12) nl_flags = 0x202 nl_type = 3
# Exception|    error: -95
# Exception|    extack: {'bad-attr': '.ifindex'}
not ok 6 rss_ctx.test_rss_context4
# Exception| Traceback (most recent call last):
# Exception|   File "/root/net-next/tools/testing/selftests/net/lib/py/ksft.py", line 244, in ksft_run
# Exception|     case(*args)
# Exception|     ~~~~^^^^^^^
# Exception|   File "/root/net-next/tools/testing/selftests/drivers/net/hw/rss_ctx.py", line 511, in test_rss_context32
# Exception|     test_rss_context(cfg, 32)
# Exception|     ~~~~~~~~~~~~~~~~^^^^^^^^^
# Exception|   File "/root/net-next/tools/testing/selftests/drivers/net/hw/rss_ctx.py", line 446, in test_rss_context
# Exception|     qcnt = len(_get_rx_cnts(cfg))
# Exception|                ~~~~~~~~~~~~^^^^^
# Exception|   File "/root/net-next/tools/testing/selftests/drivers/net/hw/rss_ctx.py", line 74, in _get_rx_cnts
# Exception|     data = cfg.netdevnl.qstats_get({"ifindex": cfg.ifindex, "scope": ["queue"]}, dump=True)
# Exception|   File "/root/net-next/tools/net/ynl/pyynl/lib/ynl.py", line 1141, in _op
# Exception|     return self._ops(ops)[0]
# Exception|            ~~~~~~~~~^^^^^
# Exception|   File "/root/net-next/tools/net/ynl/pyynl/lib/ynl.py", line 1097, in _ops
# Exception|     raise NlError(nl_msg)
# Exception| net.ynl.pyynl.lib.ynl.NlError: Netlink error: Operation not supported
# Exception| nl_len = 28 (12) nl_flags = 0x202 nl_type = 3
# Exception|    error: -95
# Exception|    extack: {'bad-attr': '.ifindex'}
not ok 7 rss_ctx.test_rss_context32
ok 8 rss_ctx.test_rss_context_dump # SKIP Unable to add any contexts
ok 9 rss_ctx.test_rss_context_queue_reconfigure # SKIP Not enough queues for the test or qstat not supported
# Exception| Traceback (most recent call last):
# Exception|   File "/root/net-next/tools/testing/selftests/net/lib/py/ksft.py", line 244, in ksft_run
# Exception|     case(*args)
# Exception|     ~~~~^^^^^^^
# Exception|   File "/root/net-next/tools/testing/selftests/drivers/net/hw/rss_ctx.py", line 607, in test_rss_context_overlap
# Exception|     queue_cnt = len(_get_rx_cnts(cfg))
# Exception|                     ~~~~~~~~~~~~^^^^^
# Exception|   File "/root/net-next/tools/testing/selftests/drivers/net/hw/rss_ctx.py", line 74, in _get_rx_cnts
# Exception|     data = cfg.netdevnl.qstats_get({"ifindex": cfg.ifindex, "scope": ["queue"]}, dump=True)
# Exception|   File "/root/net-next/tools/net/ynl/pyynl/lib/ynl.py", line 1141, in _op
# Exception|     return self._ops(ops)[0]
# Exception|            ~~~~~~~~~^^^^^
# Exception|   File "/root/net-next/tools/net/ynl/pyynl/lib/ynl.py", line 1097, in _ops
# Exception|     raise NlError(nl_msg)
# Exception| net.ynl.pyynl.lib.ynl.NlError: Netlink error: Operation not supported
# Exception| nl_len = 28 (12) nl_flags = 0x202 nl_type = 3
# Exception|    error: -95
# Exception|    extack: {'bad-attr': '.ifindex'}
not ok 10 rss_ctx.test_rss_context_overlap
# Exception| Traceback (most recent call last):
# Exception|   File "/root/net-next/tools/testing/selftests/net/lib/py/ksft.py", line 244, in ksft_run
# Exception|     case(*args)
# Exception|     ~~~~^^^^^^^
# Exception|   File "/root/net-next/tools/testing/selftests/drivers/net/hw/rss_ctx.py", line 664, in test_rss_context_overlap2
# Exception|     test_rss_context_overlap(cfg, True)
# Exception|     ~~~~~~~~~~~~~~~~~~~~~~~~^^^^^^^^^^^
# Exception|   File "/root/net-next/tools/testing/selftests/drivers/net/hw/rss_ctx.py", line 607, in test_rss_context_overlap
# Exception|     queue_cnt = len(_get_rx_cnts(cfg))
# Exception|                     ~~~~~~~~~~~~^^^^^
# Exception|   File "/root/net-next/tools/testing/selftests/drivers/net/hw/rss_ctx.py", line 74, in _get_rx_cnts
# Exception|     data = cfg.netdevnl.qstats_get({"ifindex": cfg.ifindex, "scope": ["queue"]}, dump=True)
# Exception|   File "/root/net-next/tools/net/ynl/pyynl/lib/ynl.py", line 1141, in _op
# Exception|     return self._ops(ops)[0]
# Exception|            ~~~~~~~~~^^^^^
# Exception|   File "/root/net-next/tools/net/ynl/pyynl/lib/ynl.py", line 1097, in _ops
# Exception|     raise NlError(nl_msg)
# Exception| net.ynl.pyynl.lib.ynl.NlError: Netlink error: Operation not supported
# Exception| nl_len = 28 (12) nl_flags = 0x202 nl_type = 3
# Exception|    error: -95
# Exception|    extack: {'bad-attr': '.ifindex'}
not ok 11 rss_ctx.test_rss_context_overlap2
# Exception| Traceback (most recent call last):
# Exception|   File "/root/net-next/tools/testing/selftests/net/lib/py/ksft.py", line 244, in ksft_run
# Exception|     case(*args)
# Exception|     ~~~~^^^^^^^
# Exception|   File "/root/net-next/tools/testing/selftests/drivers/net/hw/rss_ctx.py", line 534, in test_rss_context_out_of_order
# Exception|     qcnt = len(_get_rx_cnts(cfg))
# Exception|                ~~~~~~~~~~~~^^^^^
# Exception|   File "/root/net-next/tools/testing/selftests/drivers/net/hw/rss_ctx.py", line 74, in _get_rx_cnts
# Exception|     data = cfg.netdevnl.qstats_get({"ifindex": cfg.ifindex, "scope": ["queue"]}, dump=True)
# Exception|   File "/root/net-next/tools/net/ynl/pyynl/lib/ynl.py", line 1141, in _op
# Exception|     return self._ops(ops)[0]
# Exception|            ~~~~~~~~~^^^^^
# Exception|   File "/root/net-next/tools/net/ynl/pyynl/lib/ynl.py", line 1097, in _ops
# Exception|     raise NlError(nl_msg)
# Exception| net.ynl.pyynl.lib.ynl.NlError: Netlink error: Operation not supported
# Exception| nl_len = 28 (12) nl_flags = 0x202 nl_type = 3
# Exception|    error: -95
# Exception|    extack: {'bad-attr': '.ifindex'}
not ok 12 rss_ctx.test_rss_context_out_of_order
# Exception| Traceback (most recent call last):
# Exception|   File "/root/net-next/tools/testing/selftests/net/lib/py/ksft.py", line 244, in ksft_run
# Exception|     case(*args)
# Exception|     ~~~~^^^^^^^
# Exception|   File "/root/net-next/tools/testing/selftests/drivers/net/hw/rss_ctx.py", line 515, in
test_rss_context4_create_with_cfg
# Exception|     test_rss_context(cfg, 4, create_with_cfg=True)
# Exception|     ~~~~~~~~~~~~~~~~^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
# Exception|   File "/root/net-next/tools/testing/selftests/drivers/net/hw/rss_ctx.py", line 446, in test_rss_context
# Exception|     qcnt = len(_get_rx_cnts(cfg))
# Exception|                ~~~~~~~~~~~~^^^^^
# Exception|   File "/root/net-next/tools/testing/selftests/drivers/net/hw/rss_ctx.py", line 74, in _get_rx_cnts
# Exception|     data = cfg.netdevnl.qstats_get({"ifindex": cfg.ifindex, "scope": ["queue"]}, dump=True)
# Exception|   File "/root/net-next/tools/net/ynl/pyynl/lib/ynl.py", line 1141, in _op
# Exception|     return self._ops(ops)[0]
# Exception|            ~~~~~~~~~^^^^^
# Exception|   File "/root/net-next/tools/net/ynl/pyynl/lib/ynl.py", line 1097, in _ops
# Exception|     raise NlError(nl_msg)
# Exception| net.ynl.pyynl.lib.ynl.NlError: Netlink error: Operation not supported
# Exception| nl_len = 28 (12) nl_flags = 0x202 nl_type = 3
# Exception|    error: -95
# Exception|    extack: {'bad-attr': '.ifindex'}
not ok 13 rss_ctx.test_rss_context4_create_with_cfg
ok 14 rss_ctx.test_flow_add_context_missing
# Exception| Traceback (most recent call last):
# Exception|   File "/root/net-next/tools/testing/selftests/net/lib/py/ksft.py", line 244, in ksft_run
# Exception|     case(*args)
# Exception|     ~~~~^^^^^^^
# Exception|   File "/root/net-next/tools/testing/selftests/drivers/net/hw/rss_ctx.py", line 699, in test_delete_rss_context_busy
# Exception|     ctx_id = ethtool_create(cfg, "-X", "context new")
# Exception|   File "/root/net-next/tools/testing/selftests/drivers/net/hw/rss_ctx.py", line 48, in ethtool_create
# Exception|     output = ethtool(f"{act} {cfg.ifname} {opts}").stdout
# Exception|              ~~~~~~~^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
# Exception|   File "/root/net-next/tools/testing/selftests/net/lib/py/utils.py", line 194, in ethtool
# Exception|     return tool('ethtool', args, json=json, ns=ns, host=host)
# Exception|   File "/root/net-next/tools/testing/selftests/net/lib/py/utils.py", line 177, in tool
# Exception|     cmd_obj = cmd(cmd_str, ns=ns, host=host)
# Exception|   File "/root/net-next/tools/testing/selftests/net/lib/py/utils.py", line 75, in __init__
# Exception|     self.process(terminate=False, fail=fail, timeout=timeout)
# Exception|     ~~~~~~~~~~~~^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
# Exception|   File "/root/net-next/tools/testing/selftests/net/lib/py/utils.py", line 95, in process
# Exception|     raise CmdExitFailure("Command failed: %s\nSTDOUT: %s\nSTDERR: %s" %
# Exception|                          (self.proc.args, stdout, stderr), self)
# Exception| net.lib.py.utils.CmdExitFailure: Command failed: ['ethtool', '-X', 'enp17s0f0', 'context', 'new']
# Exception| STDOUT: b''
# Exception| STDERR: b'Cannot set RX flow hash configuration: Operation not supported\n'
not ok 15 rss_ctx.test_delete_rss_context_busy
# Exception| Traceback (most recent call last):
# Exception|   File "/root/net-next/tools/testing/selftests/net/lib/py/ksft.py", line 244, in ksft_run
# Exception|     case(*args)
# Exception|     ~~~~^^^^^^^
# Exception|   File "/root/net-next/tools/testing/selftests/drivers/net/hw/rss_ctx.py", line 725, in test_rss_ntuple_addition
# Exception|     queue_cnt = len(_get_rx_cnts(cfg))
# Exception|                     ~~~~~~~~~~~~^^^^^
# Exception|   File "/root/net-next/tools/testing/selftests/drivers/net/hw/rss_ctx.py", line 74, in _get_rx_cnts
# Exception|     data = cfg.netdevnl.qstats_get({"ifindex": cfg.ifindex, "scope": ["queue"]}, dump=True)
# Exception|   File "/root/net-next/tools/net/ynl/pyynl/lib/ynl.py", line 1141, in _op
# Exception|     return self._ops(ops)[0]
# Exception|            ~~~~~~~~~^^^^^
# Exception|   File "/root/net-next/tools/net/ynl/pyynl/lib/ynl.py", line 1097, in _ops
# Exception|     raise NlError(nl_msg)
# Exception| net.ynl.pyynl.lib.ynl.NlError: Netlink error: Operation not supported
# Exception| nl_len = 28 (12) nl_flags = 0x202 nl_type = 3
# Exception|    error: -95
# Exception|    extack: {'bad-attr': '.ifindex'}
not ok 16 rss_ctx.test_rss_ntuple_addition
# Exception| Traceback (most recent call last):
# Exception|   File "/root/net-next/tools/testing/selftests/net/lib/py/ksft.py", line 244, in ksft_run
# Exception|     case(*args)
# Exception|     ~~~~^^^^^^^
# Exception|   File "/root/net-next/tools/testing/selftests/drivers/net/hw/rss_ctx.py", line 768, in test_rss_default_context_rule
# Exception|     queue_cnt = len(_get_rx_cnts(cfg))
# Exception|                     ~~~~~~~~~~~~^^^^^
# Exception|   File "/root/net-next/tools/testing/selftests/drivers/net/hw/rss_ctx.py", line 74, in _get_rx_cnts
# Exception|     data = cfg.netdevnl.qstats_get({"ifindex": cfg.ifindex, "scope": ["queue"]}, dump=True)
# Exception|   File "/root/net-next/tools/net/ynl/pyynl/lib/ynl.py", line 1141, in _op
# Exception|     return self._ops(ops)[0]
# Exception|            ~~~~~~~~~^^^^^
# Exception|   File "/root/net-next/tools/net/ynl/pyynl/lib/ynl.py", line 1097, in _ops
# Exception|     raise NlError(nl_msg)
# Exception| net.ynl.pyynl.lib.ynl.NlError: Netlink error: Operation not supported
# Exception| nl_len = 28 (12) nl_flags = 0x202 nl_type = 3
# Exception|    error: -95
# Exception|    extack: {'bad-attr': '.ifindex'}
not ok 17 rss_ctx.test_rss_default_context_rule
# Totals: pass:2 fail:11 xfail:0 xpass:0 skip:4 error:0


