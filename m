Return-Path: <netdev+bounces-14521-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CE760742422
	for <lists+netdev@lfdr.de>; Thu, 29 Jun 2023 12:45:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D8D601C20970
	for <lists+netdev@lfdr.de>; Thu, 29 Jun 2023 10:45:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54CDBC154;
	Thu, 29 Jun 2023 10:45:52 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E63A19A
	for <netdev@vger.kernel.org>; Thu, 29 Jun 2023 10:45:52 +0000 (UTC)
Received: from mail-qk1-x732.google.com (mail-qk1-x732.google.com [IPv6:2607:f8b0:4864:20::732])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3E3A1FC1
	for <netdev@vger.kernel.org>; Thu, 29 Jun 2023 03:45:48 -0700 (PDT)
Received: by mail-qk1-x732.google.com with SMTP id af79cd13be357-765579770f3so19591685a.0
        for <netdev@vger.kernel.org>; Thu, 29 Jun 2023 03:45:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20221208.gappssmtp.com; s=20221208; t=1688035547; x=1690627547;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=G11jaPxFFrO+kTOm3GCj2DmJUIAmUy+nA/FMt92TcVw=;
        b=ItnTphJ7fvBdDqjM+0eaJVp70l99k4h+Gk0ipsWph2FLt6HV6iCakrMXMFLaglbVsd
         /OCLR1Y15K+172OR4uFXrT9sLkeT80PKqkN4TKJX2KG9DGoHoXSq2yobzVutSB0nwxq1
         WyEsAhcFtsAFZQBi8zk+LcxUjZAoGrU0LQUvNbVme64JZUkQFgBX2TI3w8G1EgLq2xQp
         aDC8qDhOuO8GHG/AptZU8uf8yFwBXn4Z4jK4zk/gf17evG+6xL7KWOqH0R0ouoOFrII5
         Jmj65wkhVhSyqlSnk8Wen8yvWRhDNjwlZf+KO26vDg/+4cmI/kfrtglhYOiRXy/2nu2F
         QAYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688035547; x=1690627547;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=G11jaPxFFrO+kTOm3GCj2DmJUIAmUy+nA/FMt92TcVw=;
        b=Z6lPi9rvEacWW27fl6ctRGhMPu9ErGJsD0k7AJxjzU0jMO/tcWx/ddGHng2mo0iGiV
         LlpbimJhniegZtoftpeDrqlvq1vMjHumoUdUqpEDsEQUcOzvrw0DSzIZ/dhKv+EdeQTk
         nFryEN/szrtDINIupsc3mEmqThpD3PKI5qlWetPjcfdO61Qfok+Tn22MqQKsFyTHzpZr
         AM2zWTfTzyFJdWtbwwfV8nLsU72+TJWrfoTo4OUgo9sb9yKyS4OHG3H3qL5SoEd6TKZL
         vCXbLlHKZOEpgZLIj87sXGICD2C2y0VQDv3gqFW7JWbPvVAVmaKqLNKI8GYCw09dvyey
         uyKQ==
X-Gm-Message-State: AC+VfDxcIURSyZdCS0+uoZ8Hagfs/TgLklM6UQKqcPSuSjG67md0gomU
	tTGutj7SGpSn2E6aDq+4prGXhI1aR1wE95hPWBg=
X-Google-Smtp-Source: ACHHUZ4XQaEwlsw8l1P8dG+taVEoUvHFyvhNeE92Uj8sfDAebRNfIG3nBGJgwEHpdmTpnSigRY1YSw==
X-Received: by 2002:a05:6214:2b06:b0:635:eef0:4894 with SMTP id jx6-20020a0562142b0600b00635eef04894mr6274224qvb.23.1688035547012;
        Thu, 29 Jun 2023 03:45:47 -0700 (PDT)
Received: from majuu.waya (bras-base-oshwon9577w-grc-12-142-114-148-137.dsl.bell.ca. [142.114.148.137])
        by smtp.gmail.com with ESMTPSA id o9-20020a056214180900b006362d4eeb6esm538453qvw.144.2023.06.29.03.45.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Jun 2023 03:45:46 -0700 (PDT)
From: Jamal Hadi Salim <jhs@mojatatu.com>
To: netdev@vger.kernel.org
Cc: deb.chatterjee@intel.com,
	anjali.singhai@intel.com,
	namrata.limaye@intel.com,
	tom@sipanda.io,
	mleitner@redhat.com,
	Mahesh.Shirshyad@amd.com,
	Vipin.Jain@amd.com,
	tomasz.osinski@intel.com,
	jiri@resnulli.us,
	xiyou.wangcong@gmail.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	vladbu@nvidia.com,
	simon.horman@corigine.com,
	khalidm@nvidia.com,
	toke@redhat.com,
	mattyk@nvidia.com,
	dan.daly@intel.com,
	john.andy.fingerhut@intel.com
Subject: [PATCH RFC v3 net-next 00/21] Introducing P4TC
Date: Thu, 29 Jun 2023 06:45:17 -0400
Message-Id: <20230629104538.40863-1-jhs@mojatatu.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
	T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

We are seeking community feedback on P4TC patches.

Please do note that > 50% of LOC are testcases.

Changes In Version 2
--------------------

Version 2 was the initial integration of the eBPF s/w datapath.
We took into consideration suggestions provided and added eBPF S/W datapath
support after extensive testing. We implemented 6 approaches with eBPF and ran
performance analysis and presented our results at the P4 2023 workshop in Santa
Clara[see: 1, 3] on each of the 6 vs scriptable P4TC and concluded that 2 of the
approaches are sensible (4 if you account for XDP or TC separately).

Conclusions from the exercise: We lose the simple operational model we had
prior to integrating eBPF. We do gain performance in most cases where the
datapath is less compute-bound.
For more discussion on our requirements vs journeying the ebpf path please
scroll down to "Restating Our Requirements" and "Challenges".

This patch set presented two modes.
mode1: the parser is entirely based on ebpf - whereas the rest of the
SW datapath stays as _scriptable_ as in Version 1.
mode2: All of the kernel s/w datapath (including parser) is in eBPF.

The key ingredient for eBPF, that we did not have access to in the past, is
kfunc (it made a big difference for us to reconsider eBPF).

In V2 the two modes are mutually exclusive (IOW, you get to choose one
or the other via Kconfig).

Changes in This version 3
-------------------------

These patches are still in a little bit of flux as we adjust to integrating
ebpf. So there are small constructs that are used in V1 and 2 but no longer
used in this version. We will make a V4 which will remove those.
The changes from V2 are as follows:

1) Feedback we got in V2 is to try stick to one of the two modes. In this version
we are taking one more step and going the path of mode2 vs v2 where we had 2 modes.

2) The P4 Register extern is no longer standalone. Instead, as part of integrating
into eBPF we introduce another kfunc which encapsulates Register as part of the
extern interface.

3) We have improved our CICD to include tools pointed to us by Simon. See
   "Testing" further below. Thanks to Simon for that and other issues he caught.
   Simon, we discussed on issue [7] but decided to keep that log since we think
   it is useful.

4) A lot of small cleanups. Thanks Marcelo. There are two things we need to
   rediscuss though; see: [5], [6].

5) We removed the need for a range of IDs for dynamic actions. Thanks Jakub.

6) Clarify ambiguity caused by smatch in an if(A) else if(B) condition. We are
   guaranteed that either A or B must exist; however, lets make smatch happy.
   Thanks to Simon and Dan Carpenter.

What is P4?
-----------

The Programming Protocol-independent Packet Processors (P4) is an open source,
domain-specific programming language for specifying data plane behavior.

The P4 ecosystem includes an extensive range of deployements, products, projects
and services, etc. For Details, visit: https://p4.org/

__What is P4TC?__

P4TC is an implementation of P4 building on top of many years of Linux TC
experiences. On why P4 - see small treatise here:[4].

There have been many discussions and meetings since about 2015 in regards to
P4 over TC [2] and we are finally proving the naysayers that we do get stuff
done!

A lot more of the P4TC motivation is captured at:
https://github.com/p4tc-dev/docs/blob/main/why-p4tc.md
XXX: To be updated to describe integration with eBPF s/w datapath.

In this patch series we focus on s/w datapath only.

__P4TC Workflow__

These patches enable kernel and user space code change _independency_ for any
new P4 program that describes a new datapath. The workflow is as follows:

  1) A developer writes a P4 program, "myprog"

  2) Compiles it using the P4C compiler[8]. The compiler generates 3 outputs:
     a) shell script(s) which form template definitions for the different P4
     objects "myprog" utilizes (tables, externs, actions etc).
     b) the parser and the rest of the sw datapath are generated
     in ebpf and need to be compiled into binaries.
     c) A json introspection file used for control plane (by iproute2/tc).

  3) The developer (or operator) executes the shell script(s) to manifest the
     functional s/w equivalent of "myprog" into the kernel.

  4) The developer (or operator) instantiates "myprog" via the tc P4 filter
     to ingress/egress (depending on P4 arch) of one or more netdevs/ports.

     Example1: parser is an action:
       "tc filter add block 22 ingress protocol any prio 1 p4 pname myprog \
        action bpf obj $PARSER.o section parser/tc-ingress \
        action bpf obj $PROGNAME.o section p4prog/tc"

     Example2: parser explicitly bound and rest of sw dpath as an action:
       "tc filter add block 22 ingress protocol any prio 1 p4 pname myprog \
        prog tc obj $PARSER.o section parser/tc-ingress \
        action bpf obj $PROGNAME.o section p4prog/tc"

     Example3: parser is at XDP, rest of sw dpath as an action:
       "tc filter add block 22 ingress protocol any prio 1 p4 pname myprog \
        prog xdp obj $PARSER.o section parser/xdp-ingress \
        action bpf obj $PROGNAME.o section p4prog/tc"

     Example4: parser+prog at XDP:
       "tc filter add block 22 ingress protocol any prio 1 p4 pname myprog \
        prog xdp obj $PROGNAME.o section p4prog/xdp"

    see individual patches for more examples tc vs xdp etc. Also see section on
    "challenges".

Once "myprog" is instantiated one can start updating table entries that are
associated with "myprog". Example:
  tc p4runtime create myprog/mytable dstAddr 10.0.1.2/32 \
    action send_to_port param port eno1

A packet arriving on ingress of any of the ports on block 22 will first be
exercised via the (ebpf) parser to find the headers pointing to the ip
destination address.
The remainder ebpf datapath uses the result dstAddr as a key to (kfunc) lookup
myprog's mytable which returns the action params which are then used to execute
the action in the ebpf datapath (eventually sending out packets to eno1).
On a miss, mytable's default miss action is executed.

__Description of Patches__

P4TC is designed to have no impact on the core code for other users
of TC. IOW, you can compile it out or as a module and if you dont use
it then there should be no impact on your performance.

We do make core kernel changes. Patch #1 introduces new "dynamic" actions
that can be created on "the fly" based on the P4 program requirement.
This patch makes a small incision into act_api which shouldnt affect the
performance of the existing actions. Patches 2-6 are minimalist enablers for
P4TC and have no effect the classical tc action.

The core P4TC code implements several P4 objects.

1) Patch #7 introduces P4 data types which are consumed by the rest of the code
2) Patch #8 introduces the concept of templating Pipelines. i.e CRUD commands
   for P4 pipelines.
3) Patch #9 introduces the concept of P4 header fields and associated CRUD
   template commands.
4) Patch #10 introduces the concept of action templates and associated
   CRUD commands.
5) Patch #11 introduces the concept of P4 table templates and associated
   CRUD commands for tables
6) Patch #12 introduces table entries and associated CRUD commands.
7) Patch #13 introduces interaction of eBPF to P4TC domain via kfunc.
8) Patch #14 introduces the TC classifier P4 used at runtime. Only with
    mode1 support.
9) Patch #15 introduces extern interfacing
10) Patches #16-20 are control tests for the different objects

__Testing__

Speaking of testing - we have about 400 tdc test cases. This number is growing.
These tests are run on our CICD system on pull requests and after commits are
approved. The CICD does a lot of other tests (more since v2) including:
checkpatch, sparse, smatch, coccinelle, 32 bit and 64 bit builds tested on both
X86, ARM 64 and emulated BE via qemu s390. We trigger performance testing in the
CICD to catch performance regressions (currently only on the control path, but
in the future for the datapath).
Syzkaller runs 24/7 on dedicated hardware, originally we focussed only on memory
sanitizer but recently added support for concurency sanitizer.
Before main releases we ensure each patch will compile on its own to help in
git bisect and run the xmas tree tool. We eventually put the code via coverity.

In addition we are working on a tool that will take a p4 program, run it through
the compiler, and generate permutations of traffic patterns via symbolic
execution that will test both positive and negative datapath code paths. The
test generator tool is still work in progress and will be generated by the P4
compiler.
Note: We have other code that test parallelization etc which we are trying to
find a fit for in the kernel tree.

__Restating Our Requirements__

Our original intent was to target the TC crowd for both s/w and h/w offload.
Essentially developers and ops people deploying TC based infra.
More importantly the original intent for P4TC was to enable ops folks more than
devs.

With TC we get whole "familiar" package of match-action pipeline abstraction ++:
from the control plane to the tooling infra, netlink messaging to s/w and h/w
symbiosis, the autonomous kernel control, etc. The advantage is that we have a
singular vendor-neutral interface via the kernel using well understood
mechanisms based on deployment experience.

1) Supporting expressibility of universe set of P4 progs

It is a must to support 100% of all possible P4 programs. In the past the eBPF
verifier had to be worked around and even then there are cases where we couldnt
avoid path explosion when branching is involved. Kfunc-ing solves these issues
for us. Note, there are still challenges running all potential P4 programs at
the XDP level - the solution to that is to have the compiler generate XDP based
code only if it possible to map it to that layer.

2) Support for P4 HW and SW equivalence.

This feature continues to work even in the presence of eBPF as the s/w
datapath. There are cases of square-hole-round-peg scenarios but
those are implementation issues we can live with.

3) Operational usability

By maintaining the TC control plane (even in presence of eBPF s/w datapath)
runtime aspects remain unchanged. So for our target audience of folks
who have deployed tc including offloads - the comfort zone is unchanged.

There is some loss in operational usability because we now have more knobs:
the extra compilation, loading and syncing of binaries, etc.
IOW, I can no longer just ship someone a shell script in an email to
say go run this and "myprog" will just work.

4) Operational and development Debuggability

If something goes wrong, the tc craftsperson is now required to have additional
knowledge of eBPF code and process. This applies to both the operational person
as well as someone who wrote a driver. We dont believe this is solvable.

5) Opportunity for rapid protoyping of new ideas

During the P4TC development phase something that came naturally was to often
handcode the template scripts because the compiler backend (which is P4 arch
specific) wasnt ready to generate certain things. Then you would read back the
template and diff to ensure the kernel didnt get something wrong. So this
started as a debug feature. During development, we wrote scripts that
covered a range of P4 architectures(PSA, V1, etc) which required no kernel code
changes.

In its basic form it boils down to the old adage of a niche DSL script vs a
compiled general purpose language such as eBPF. Given our target audience who
know P4/TC, and understand our hooks, the shell script whose command set is more
aligned to P4 is a natural fit compared to handcoding eBPF.

Over time the debug feature morphed into: start by handcoding scripts then
read it back and then generate the P4 code.
It means one could start with the template scripts outside of the constraints
of a P4 architecture spec(PNA/PSA) or even within a P4 architecture then test
some ideas and eventually feed back the concepts to the compiler authors or
modify or create a new P4 architecure and share with the P4 standards folks.

To summarize in presence of eBPF: The debugging idea is still alive.
One could dump with proper tooling(bpftool for example) the loaded eBPF code
and be able to check for differences.
The concept of going back from whats in the kernel to P4 is a lot more difficult
to implement mostly due to scoping of DSL vs general purpose. It may be lost.
We have been thinking of ways to use BTF and embedding annotations in the eBPF
code and binary but more thought is required and we welcome suggestions.

6) Performance

It is clear you gain better performance for the sw datapath with eBPF. Refer to
our results for the tests we did[1].
Note: for computationaly complex programs this value diminishes i.e the
gap between XDP and TC eBPF or even in some cases scriptable approach is not
prominent; however, we do acknowledge there is an observable performance gain
as expected (compiled vs interpreted approach).

__Challenges__

1) When we have either the parser or part/whole of s/w datapath running in XDP
   then we need to make sure that the instantiation at the TC level is aware.
   For this we reason we need a mechanism for ensuring that the XDP program
   stays alive. Unfortunately we dont have a clean way of doing this at the
   moment i.e the program could be removed under us. It would be useful to have
   a refcount mechanism where the program cant be unbound from a port/netdev.
   Andrii Nakryiko made a suggestion to use bpf link for XDP which we are going
   to try out.

2) Concept of tc block in XDP is tedious to implement.

3) Right now we are using "packed" construct to enforce alignment in kfunc data
   exchange; but we're wondering if there is potential to use BTF to understand
   parameters and their offsets and encode this information at the compiler
   level.

4) At the moment we are creating a static buffer of 128B to retrieve the action
   parameters. If you have a lot of table entries and individual(non-shared)
   action instances with actions that require very little (or no) param space
   a lot of memory is wasted. If we can have dynamic pointers instead for
   kfunc fixed length parametrization then this issue is resolvable.

5) See "Restating Our Requirements" #5.
   We would really appreciate ideas/suggestions, etc.

__References__

[1]https://github.com/p4tc-dev/docs/blob/main/p4-conference-2023/2023P4WorkshopP4TC.pdf
[2]https://github.com/p4tc-dev/docs/blob/main/why-p4tc.md#historical-perspective-for-p4tc
[3]https://2023p4workshop.sched.com/event/1KsAe/p4tc-linux-kernel-p4-implementation-approaches-and-evaluation
[4]https://github.com/p4tc-dev/docs/blob/main/why-p4tc.md#so-why-p4-and-how-does-p4-help-here
[5]https://lore.kernel.org/netdev/20230517110232.29349-3-jhs@mojatatu.com/T/#mf59be7abc5df3473cff3879c8cc3e2369c0640a6
[6]https://lore.kernel.org/netdev/20230517110232.29349-3-jhs@mojatatu.com/T/#m783cfd79e9d755cf0e7afc1a7d5404635a5b1919
[7]https://lore.kernel.org/netdev/20230517110232.29349-3-jhs@mojatatu.com/T/#ma8c84df0f7043d17b98f3d67aab0f4904c600469
[8]https://github.com/p4lang/p4c/tree/main/backends/tc

Jamal Hadi Salim (21):
  net: sched: act_api: Add dynamic actions IDR
  net/sched: act_api: increase action kind string length
  net/sched: act_api: add init_ops to struct tc_action_op
  net/sched: act_api: export generic tc action searcher
  net/sched: act_api: add struct p4tc_action_ops as a parameter to
    lookup callback
  net: introduce rcu_replace_pointer_rtnl
  p4tc: add P4 data types
  p4tc: add pipeline create, get, update, delete
  p4tc: add header field create, get, delete, flush and dump
  p4tc: add action template create, update, delete, get, flush and dump
  p4tc: add table create, update, delete, get, flush and dump
  p4tc: add table entry create, update, get, delete, flush and dump
  p4tc: add set of P4TC table lookup kfuncs
  p4tc: add P4 classifier
  p4tc: Add P4 externs
  selftests: tc-testing: add JSON introspection file directory for P4TC
  selftests: tc-testing: add P4TC pipeline control path tdc tests
  selftests: tc-testing: add P4TC action templates tdc tests
  selftests: tc-testing: add P4TC table control path tdc tests
  selftests: tc-testing: add P4TC table entries control path tdc tests
  MAINTAINERS: add p4tc entry

 MAINTAINERS                                   |    14 +
 include/linux/bitops.h                        |     1 +
 include/linux/rtnetlink.h                     |    12 +
 include/net/act_api.h                         |    20 +-
 include/net/p4tc.h                            |   649 +
 include/net/p4tc_ext_api.h                    |    87 +
 include/net/p4tc_types.h                      |    87 +
 include/net/tc_act/p4tc.h                     |    25 +
 include/uapi/linux/p4tc.h                     |   389 +
 include/uapi/linux/p4tc_ext.h                 |    38 +
 include/uapi/linux/pkt_cls.h                  |    21 +-
 include/uapi/linux/rtnetlink.h                |    14 +
 net/sched/Kconfig                             |    21 +
 net/sched/Makefile                            |     3 +
 net/sched/act_api.c                           |   158 +-
 net/sched/cls_api.c                           |     2 +-
 net/sched/cls_p4.c                            |   497 +
 net/sched/p4tc/Makefile                       |     8 +
 net/sched/p4tc/p4tc_action.c                  |  1725 +++
 net/sched/p4tc/p4tc_bpf.c                     |   129 +
 net/sched/p4tc/p4tc_ext.c                     |  1978 +++
 net/sched/p4tc/p4tc_hdrfield.c                |   597 +
 net/sched/p4tc/p4tc_parser_api.c              |   146 +
 net/sched/p4tc/p4tc_pipeline.c                |   694 +
 net/sched/p4tc/p4tc_runtime_api.c             |   144 +
 net/sched/p4tc/p4tc_table.c                   |  1451 ++
 net/sched/p4tc/p4tc_tbl_entry.c               |  2068 +++
 net/sched/p4tc/p4tc_tmpl_api.c                |   594 +
 net/sched/p4tc/p4tc_tmpl_ext.c                |  2256 +++
 net/sched/p4tc/p4tc_types.c                   |  1255 ++
 net/sched/p4tc/trace.c                        |    10 +
 net/sched/p4tc/trace.h                        |    44 +
 security/selinux/nlmsgtab.c                   |     8 +-
 .../introspection-examples/example_pipe.json  |    92 +
 .../tc-tests/p4tc/action_templates.json       | 12378 ++++++++++++++++
 .../tc-testing/tc-tests/p4tc/pipeline.json    |  3212 ++++
 .../tc-testing/tc-tests/p4tc/table.json       |  8956 +++++++++++
 .../tc-tests/p4tc/table_entries.json          |  3818 +++++
 38 files changed, 43572 insertions(+), 29 deletions(-)
 create mode 100644 include/net/p4tc.h
 create mode 100644 include/net/p4tc_ext_api.h
 create mode 100644 include/net/p4tc_types.h
 create mode 100644 include/net/tc_act/p4tc.h
 create mode 100644 include/uapi/linux/p4tc.h
 create mode 100644 include/uapi/linux/p4tc_ext.h
 create mode 100644 net/sched/cls_p4.c
 create mode 100644 net/sched/p4tc/Makefile
 create mode 100644 net/sched/p4tc/p4tc_action.c
 create mode 100644 net/sched/p4tc/p4tc_bpf.c
 create mode 100644 net/sched/p4tc/p4tc_ext.c
 create mode 100644 net/sched/p4tc/p4tc_hdrfield.c
 create mode 100644 net/sched/p4tc/p4tc_parser_api.c
 create mode 100644 net/sched/p4tc/p4tc_pipeline.c
 create mode 100644 net/sched/p4tc/p4tc_runtime_api.c
 create mode 100644 net/sched/p4tc/p4tc_table.c
 create mode 100644 net/sched/p4tc/p4tc_tbl_entry.c
 create mode 100644 net/sched/p4tc/p4tc_tmpl_api.c
 create mode 100644 net/sched/p4tc/p4tc_tmpl_ext.c
 create mode 100644 net/sched/p4tc/p4tc_types.c
 create mode 100644 net/sched/p4tc/trace.c
 create mode 100644 net/sched/p4tc/trace.h
 create mode 100644 tools/testing/selftests/tc-testing/introspection-examples/example_pipe.json
 create mode 100644 tools/testing/selftests/tc-testing/tc-tests/p4tc/action_templates.json
 create mode 100644 tools/testing/selftests/tc-testing/tc-tests/p4tc/pipeline.json
 create mode 100644 tools/testing/selftests/tc-testing/tc-tests/p4tc/table.json
 create mode 100644 tools/testing/selftests/tc-testing/tc-tests/p4tc/table_entries.json

-- 
2.34.1


